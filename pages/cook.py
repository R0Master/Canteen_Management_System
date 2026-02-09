import json
from datetime import date, datetime, timedelta

from flask import abort, flash, g, redirect, render_template, request, url_for
from flask_login import current_user, login_required
from sqlalchemy import func
from sqlalchemy.orm import joinedload

from .units import (
    default_packs,
    fmt_pack_label,
    fmt_buy_label,
    fmt_need_label,
    fmt_number,
    fmt_stock_qty,
    status_ru,
)


from models import (
    Ingredient,
    InventoryIngredient,
    MenuDay,
    MenuDayItem,
    MenuItemIngredient,
    Order,
    PurchaseRequest,
    PurchaseRequestItem,
)
from .common import _has_role, pages_bp


ALLOWED_MEAL_TYPES = {"BREAKFAST", "LUNCH"}




def _cook_load_orders(db, selected_date: date, meal_type: str) -> list[Order]:
    return (
        db.query(Order)
        .options(
            joinedload(Order.user),
            joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_item),
            joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_day),
        )
        .join(Order.menu_day_item)
        .join(MenuDayItem.menu_day)
        .filter(MenuDay.menu_date == selected_date)
        .filter(MenuDay.meal_type == meal_type)
        .filter(Order.status != "CANCELLED")
        .order_by(Order.created_at.asc())
        .all()
    )


def _build_issue_column_ctx(orders: list[Order]) -> dict:
    to_issue_orders = [o for o in orders if (o.status or "").upper() == "PAID"]
    issued_orders = [o for o in orders if (o.status or "").upper() == "ISSUED"]

    return {
        "to_issue_orders": to_issue_orders,
        "issued_orders": issued_orders,
        "paid_total": len(to_issue_orders) + len(issued_orders),
        "issued_count": len(issued_orders),
        "issue_totals": _paid_totals_by_item(to_issue_orders),
    }



#расчет остатков и потребностей на 5 рабочих дней
def calc_stock_5_workdays(db, start_date: date) -> dict:
    workdays = get_next_5_workdays(start_date)

    portions_rows = (
        db.query(
            MenuDayItem.menu_item_id,
            func.count(Order.id).label("portions"),
        )
        .join(Order, Order.menu_day_item_id == MenuDayItem.id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .filter(
            MenuDay.menu_date.in_(workdays),
            Order.status.in_(["PAID", "ISSUED"]),
        )
        .group_by(MenuDayItem.menu_item_id)
        .all()
    )

    need_by_ingredient: dict[int, float] = {}

    for menu_item_id, portions in portions_rows:
        portions_i = int(portions or 0)
        recipe_items = (
            db.query(MenuItemIngredient)
            .filter(MenuItemIngredient.menu_item_id == menu_item_id)
            .all()
        )
        for ri in recipe_items:
            ing_id = int(ri.ingredient_id)
            need_by_ingredient[ing_id] = need_by_ingredient.get(ing_id, 0.0) + float(ri.qty_per_portion) * portions_i

    ing_ids = list(need_by_ingredient.keys())
    if not ing_ids:
        return {
            "ok": True,
            "deficits": [],
            "by_id": {},
            "workdays": workdays,
            "start_date": start_date,
        }

    inv_rows = (
        db.query(
            Ingredient.id,
            Ingredient.name,
            Ingredient.unit,
            Ingredient.purchase_pack_qty,
            InventoryIngredient.on_hand,
        )
        .outerjoin(InventoryIngredient, InventoryIngredient.ingredient_id == Ingredient.id)
        .filter(Ingredient.id.in_(ing_ids))
        .all()
    )

    on_order_rows = (
        db.query(
            PurchaseRequestItem.ingredient_id,
            func.coalesce(func.sum(PurchaseRequestItem.qty), 0),
        )
        .join(PurchaseRequest, PurchaseRequest.id == PurchaseRequestItem.purchase_request_id)
        .filter(
            PurchaseRequest.status.in_(["CREATED", "APPROVED"]),
            PurchaseRequestItem.ingredient_id.in_(ing_ids),
        )
        .group_by(PurchaseRequestItem.ingredient_id)
        .all()
    )
    on_order_map: dict[int, float] = {int(i): float(q or 0) for i, q in on_order_rows}

    by_id: dict[int, dict] = {}
    deficits: list[dict] = []

    for ing_id, name, unit, pack_qty, on_hand in inv_rows:
        ing_id_i = int(ing_id)
        need = float(need_by_ingredient.get(ing_id_i, 0.0))
        on_hand_val = float(on_hand or 0.0)
        on_order_val = float(on_order_map.get(ing_id_i, 0.0))

        effective = on_hand_val + on_order_val
        deficit = max(need - effective, 0.0)
        deficit_stock = max(need - on_hand_val, 0.0)

        rec = {
            "ingredient_id": ing_id_i,
            "name": name,
            "unit": unit,
            "purchase_pack_qty": float(pack_qty or 0.0),
            "need": need,
            "on_hand": on_hand_val,
            "on_order": on_order_val,
            "effective": effective,
            "deficit": deficit,
            "deficit_stock": deficit_stock,
        }

        by_id[ing_id_i] = rec
        if deficit > 0:
            deficits.append(rec)

    return {
        "ok": len(deficits) == 0,
        "deficits": deficits,
        "by_id": by_id,
        "workdays": workdays,
        "start_date": start_date,
    }



def get_next_5_workdays(start_date: date) -> list[date]:
    days = []
    cur = start_date
    while len(days) < 5:
        if cur.weekday() < 5:  # 0-4 это пн–пт
            days.append(cur)
        cur += timedelta(days=1)
    return days


def _parse_date(value: str | None) -> date | None:
    if not value:
        return None
    v = value.strip()
    if not v:
        return None
    try:
        return datetime.strptime(v, "%Y-%m-%d").date()
    except ValueError:
        return None


def _parse_meal_type(value: str | None) -> str:
    mt = (value or "").strip().upper()
    if mt in ALLOWED_MEAL_TYPES:
        return mt
    return "BREAKFAST"


def _enabled_dates_for_calendar(db) -> list[str]:
    # Берём даты, где меню опубликовано (как у студента)
    rows = (
        db.query(MenuDay.menu_date)
        .filter(MenuDay.is_published.is_(True))
        .distinct()
        .order_by(MenuDay.menu_date)
        .all()
    )
    return [d[0].isoformat() for d in rows]

# сводка по блюдам для экрана готовки
def _prepare_summary_by_item_all(orders: list[Order]) -> dict[str, dict[str, int]]:
    res: dict[str, dict[str, int]] = {}
    for o in orders:
        mi = o.menu_day_item.menu_item if o.menu_day_item else None
        name = mi.name if mi else "UNKNOWN"
        st = (o.status or "").upper()

        bucket = res.setdefault(name, {"paid": 0, "created": 0, "total": 0})

        if st == "CREATED":
            bucket["created"] += 1
            bucket["total"] += 1
        elif st == "PAID":
            bucket["paid"] += 1
            bucket["total"] += 1
        elif st == "ISSUED":
            bucket["paid"] += 1          # считаем как оплачено
            bucket["total"] += 1

    return res


def _paid_totals_by_item(orders: list[Order]) -> dict[str, int]:
    totals: dict[str, int] = {}
    for o in orders:
        mdi = o.menu_day_item
        mi = mdi.menu_item if mdi else None
        name = mi.name if mi else "UNKNOWN"
        totals[name] = totals.get(name, 0) + 1
    return totals



@pages_bp.get("/cook")
@login_required
def cook_dashboard():
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    selected_date = _parse_date(request.args.get("date")) or date.today()
    meal_type = _parse_meal_type(request.args.get("meal_type"))
    can_issue = True

    date_options = [date.today() + timedelta(days=i) for i in range(0, 7)]

    #заказы на дату + приём пищи
    orders = _cook_load_orders(db, selected_date, meal_type)

    #табло готовки (CREATED + PAID + ISSUED)
    prepare_summary = _prepare_summary_by_item_all(orders)

    #правая колонка "выдача" (PAID/ISSUED + счётчики)
    issue_ctx = _build_issue_column_ctx(orders)

    #календарь дат с опубликованным меню
    enabled_dates = _enabled_dates_for_calendar(db)
    enabled_dates_json = json.dumps(enabled_dates)

    today = date.today()
    future_enabled = [iso for iso in enabled_dates if date.fromisoformat(iso) >= today]
    first_selectable_date = future_enabled[0] if future_enabled else None

    # склад/закупки - всегда считаем от TODAY, а не от выбранной даты
    stock_base_date = date.today()
    stock = calc_stock_5_workdays(db, stock_base_date)
    stock_ok = bool(stock.get("ok"))
    stock_deficit_count = len(stock.get("deficits") or [])

    return render_template(
        "cook/dashboard.html",
        selected_date=selected_date,
        meal_type=meal_type,
        date_options=date_options,
        prepare_summary=prepare_summary,

        # календарь
        enabled_dates=enabled_dates,
        enabled_dates_json=enabled_dates_json,
        first_selectable_date=first_selectable_date,

        # склад
        stock_ok=stock_ok,
        stock_deficit_count=stock_deficit_count,
        stock_base_date=stock_base_date,
        stock_horizon_label="5 учебных дней",

        # выдача
        can_issue=can_issue,
        **issue_ctx,
    )





@pages_bp.post("/cook/orders/<int:order_id>/issue")
@login_required
def cook_issue_order(order_id: int):
    # проверка роли
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    # берём заказ
    o = db.get(Order, order_id)
    if not o:
        abort(404)

    # выдавать можно только PAID
    if (o.status or "").upper() != "PAID":
        abort(409)

    # --- ПРОВЕРКА ДАТЫ ПИТАНИЯ ---
    mdi = o.menu_day_item
    md = mdi.menu_day if mdi else None
    if not md:
        abort(409)

    today = date.today()
    if md.menu_date != today:
        abort(409)  # нельзя выдавать не за сегодня


    # переводим в ISSUED
    o.status = "ISSUED"
    o.issued_at = datetime.utcnow()
    db.commit()

    #HTMX - пересобираем ПРАВУЮ колонку и возвращаем ее
    date_str = (request.form.get("date") or "").strip()
    meal_type = (request.form.get("meal_type") or "BREAKFAST").upper()

    try:
        selected_date = datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError:
        selected_date = date.today()

    orders = _cook_load_orders(db, selected_date, meal_type)
    issue_ctx = _build_issue_column_ctx(orders)

    can_issue = True

    return render_template(
        "cook/_issue_column.html",
        selected_date=selected_date,
        meal_type=meal_type,
        can_issue=can_issue,
        **issue_ctx,
    )


@pages_bp.get("/cook/purchase-requests/new")
@login_required
def cook_purchase_request_new():
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    base_date = date.today()  # ВАЖНО: всегда today
    stock = calc_stock_5_workdays(db, base_date)
    deficits = stock.get("deficits") or []

    # карта дефицитов по ingredient_id
    deficit_map = {int(d["ingredient_id"]): d for d in deficits}

    # остатки склада одним запросом (чтобы не делать много запросов в цикле)
    inv_rows = (
        db.query(InventoryIngredient.ingredient_id, InventoryIngredient.on_hand)
        .all()
    )
    on_hand_map: dict[int, float] = {int(i): float(q or 0.0) for i, q in inv_rows}

   
    by_id = stock.get("by_id") or {}  # {ingredient_id: {on_order: ... , need: ...}}

    # берем ВСЕ активные ингредиенты
    ingredients = (
        db.query(Ingredient)
        .filter(Ingredient.is_active.is_(True))
        .order_by(Ingredient.name.asc())
        .all()
    )

    items = []
    for ing in ingredients:
        ing_id = int(ing.id)
        d = deficit_map.get(ing_id)

        # --- текущие остатки / в пути (в базовых единицах) ---
        on_hand_base = float(on_hand_map.get(ing_id, 0.0) or 0.0)
        on_order_base = float((by_id.get(ing_id) or {}).get("on_order", 0.0) or 0.0)

        
        on_hand_s, _ = fmt_stock_qty(on_hand_base, ing.unit)
        on_order_s, _ = fmt_stock_qty(on_order_base, ing.unit)

        
        need_base = float(d["deficit"] or 0) if d else 0.0

        pack_qty_base = float(getattr(ing, "purchase_pack_qty", 0) or 0)
        packs_suggest = default_packs(need_base, pack_qty_base) if (d and pack_qty_base > 0) else 0

        items.append({
            "ingredient_id": ing_id,
            "name": ing.name,
            "unit": ing.unit,

            "on_hand_s": on_hand_s,
            "on_order_s": on_order_s,

            # это “рекомендация” только для дефицитных
            "is_deficit": bool(d),

            "need_label": fmt_need_label(need_base, ing.unit) if d else "—",
            "pack_label": fmt_pack_label(pack_qty_base, ing.unit) if pack_qty_base > 0 else "—",

            
            "packs": packs_suggest,
            "buy_label": fmt_buy_label(packs_suggest, pack_qty_base, ing.unit) if pack_qty_base > 0 else "—",

            
            "pack_qty_base": pack_qty_base,
            "unit_base": ing.unit,
        })

    
    return render_template(
        "cook/purchase_request_new.html",
        items=items,
        stock_base_date=base_date,
        stock_horizon_label="5 учебных дней",
    )




@pages_bp.post("/cook/purchase-requests/create")
@login_required
def cook_create_purchase_request():
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db
    base_date = date.today()  # всегда today

    stock = calc_stock_5_workdays(db, base_date)
    deficits = stock.get("deficits") or []
    deficit_ids = {int(d["ingredient_id"]) for d in deficits}

    # какие строки оставили галочкой
    selected_ids: set[int] = set()
    for key in request.form.keys():
        if key.startswith("use_"):
            try:
                selected_ids.add(int(key.split("_", 1)[1]))
            except ValueError:
                pass

    # если пользователь ничего не выбрал — значит отменил всё
    if not selected_ids:
        flash("Заявка не создана: не выбрано ни одной позиции.", "warning")
        return redirect(url_for("pages.cook_purchase_request_new"))

    
    ing_ids = sorted(list(selected_ids))
    ingredients = (
        db.query(Ingredient)
        .filter(
            Ingredient.is_active.is_(True),
            Ingredient.id.in_(ing_ids),
        )
        .all()
    )
    ing_by_id = {int(i.id): i for i in ingredients}

    # создаём заявку
    cook_name = f"{current_user.last_name} {current_user.first_name}".strip()

    # небольшой бонус: если были дефициты, отметим это в комментарии (не обяз.)
    deficit_note = ""
    if deficit_ids:
        chosen_deficits = len([i for i in ing_ids if i in deficit_ids])
        deficit_note = f" Дефицитных позиций выбрано: {chosen_deficits}."

    pr = PurchaseRequest(
        created_by_user_id=current_user.id,
        status="CREATED",
        comment=f"Сформировал(а): {cook_name}. Период: 5 учебных дней от {base_date.isoformat()}.{deficit_note}",
    )
    db.add(pr)
    db.flush()

    created_count = 0

    
    for ing_id in ing_ids:
        ing = ing_by_id.get(int(ing_id))
        if not ing:
            continue

        packs_raw = (request.form.get(f"packs_{ing_id}") or "").strip()
        try:
            packs = int(packs_raw) if packs_raw != "" else 0
        except ValueError:
            packs = 0

        if packs <= 0:
            continue  # не покупаем

        pack_qty = float(getattr(ing, "purchase_pack_qty", 1) or 1)
        if pack_qty <= 0:
            pack_qty = 1.0

        qty_to_buy = packs * pack_qty

        db.add(
            PurchaseRequestItem(
                purchase_request_id=pr.id,
                ingredient_id=int(ing_id),
                qty=qty_to_buy,
            )
        )
        created_count += 1

    if created_count == 0:
        # Если галочки были, но packs везде 0 — заявку не создаём
        db.rollback()
        flash("Заявка не создана: у выбранных позиций количество упаковок = 0.", "warning")
        return redirect(url_for("pages.cook_purchase_request_new"))

    db.commit()

    flash("Заявка создана.", "success")
    return redirect(url_for("pages.view_purchase_request", request_id=pr.id))

    
    
@pages_bp.get("/cook/purchase-requests/<int:request_id>")
@login_required
def view_purchase_request(request_id: int):
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    pr = (
        db.query(PurchaseRequest)
        .options(joinedload(PurchaseRequest.items).joinedload(PurchaseRequestItem.ingredient))
        .filter(PurchaseRequest.id == request_id)
        .one_or_none()
    )
    if not pr:
        abort(404)

    rows = []
    for it in (pr.items or []):
        ing = it.ingredient
        if not ing:
            continue

        qty_base = float(it.qty or 0)
        pack_qty_base = float(getattr(ing, "purchase_pack_qty", 0) or 0)

        packs = int(round(qty_base / pack_qty_base)) if pack_qty_base > 0 else 0

        rows.append({
            "name": ing.name,
            "packs": packs,
            "pack_label": fmt_pack_label(pack_qty_base, ing.unit),
            "buy_label": fmt_buy_label(packs, pack_qty_base, ing.unit),
        })

    rows.sort(key=lambda x: x["name"])


    cook_name = ""
    if getattr(pr, "created_by", None):
        cook_name = f"{pr.created_by.last_name} {pr.created_by.first_name}".strip()

    return render_template(
        "cook/purchase_request.html",
        pr=pr,
        cook_name=cook_name,
        rows=rows,
        status_label=status_ru(pr.status),
    )






@pages_bp.get("/cook/purchase-requests")
@login_required
def cook_purchase_requests():
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    prs = (
        db.query(PurchaseRequest)
        .filter(PurchaseRequest.created_by_user_id == current_user.id)
        .order_by(PurchaseRequest.created_at.desc())
        .all()
    )

    return render_template("cook/purchase_requests.html", prs=prs)


@pages_bp.get("/cook/inventory")
@login_required
def cook_inventory():
    if not _has_role(current_user, "cook"):
        abort(403)

    db = g.db

    start_date = date.today()
    stock = calc_stock_5_workdays(db, start_date)

    by_id: dict[int, dict] = stock.get("by_id") or {}

    rows = (
        db.query(
            Ingredient.id,
            Ingredient.name,
            Ingredient.unit,
            Ingredient.purchase_pack_qty,
            InventoryIngredient.on_hand,
        )
        .outerjoin(InventoryIngredient, InventoryIngredient.ingredient_id == Ingredient.id)
        .filter(Ingredient.is_active.is_(True))
        .order_by(Ingredient.name.asc())
        .all()
    )

    items = []
    deficit_count = 0

    for ing_id, name, unit, pack_qty, on_hand in rows:
        ing_id_i = int(ing_id)
        calc = by_id.get(ing_id_i, {})

        need = float(calc.get("need", 0.0) or 0.0)
        on_hand_val = float(on_hand or 0.0)
        on_order_val = float(calc.get("on_order", 0.0) or 0.0)

        deficit_stock = max(need - on_hand_val, 0.0)

        effective = on_hand_val + on_order_val
        deficit_with_orders = max(need - effective, 0.0)

        if deficit_with_orders > 0:
            deficit_count += 1

        on_hand_s, unit_disp = fmt_stock_qty(on_hand_val, unit)
        on_order_s, _ = fmt_stock_qty(on_order_val, unit)
        need_s, _ = fmt_stock_qty(need, unit)
        deficit_stock_s, _ = fmt_stock_qty(deficit_stock, unit)
        deficit_orders_s, _ = fmt_stock_qty(deficit_with_orders, unit)

        items.append(
            {
                "ingredient_id": ing_id_i,
                "name": name,
                "unit": unit_disp,
                "on_hand": on_hand_val,
                "on_order": on_order_val,
                "need": need,
                "deficit_stock": deficit_stock,
                "deficit": deficit_with_orders,
                "on_hand_s": on_hand_s,
                "on_order_s": on_order_s,
                "need_s": need_s,
                "deficit_stock_s": deficit_stock_s,
                "deficit_s": deficit_orders_s,
            }
        )

    any_on_hand = any((it["on_hand"] or 0) > 0 for it in items)
    any_need = any((it["need"] or 0) > 0 for it in items)
    any_on_order = any((it["on_order"] or 0) > 0 for it in items)

    deficit_stock_count = sum(1 for it in items if (it["deficit_stock"] or 0) > 0)

    stock_ok = deficit_count == 0

    return render_template(
        "cook/inventory.html",
        stock_ok=stock_ok,
        deficit_count=deficit_count,
        items=items,
        stock_base_date=start_date,
        stock_horizon_label="5 учебных дней",
        deficit_stock_count=deficit_stock_count,
        any_on_hand=any_on_hand,
        any_on_order=any_on_order,
        any_need=any_need,
    )
