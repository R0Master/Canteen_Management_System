import json
import logging
from datetime import date, timedelta, datetime
from flask import flash
from flask import render_template, request, redirect, url_for, g
from flask_login import current_user, login_required
from flask import abort, session
from sqlalchemy.orm import joinedload


from utils import ALLERGEN_LABELS_RU
from models import User, MenuDay, MenuDayItem, MenuItem, Order, Review, Payment

from .common import pages_bp, _has_role


log = logging.getLogger("ui_auth")

#рейтинги по блюдам + могу ли я оценивать
def _rating_maps_for_menu_items(db, menu_item_ids: list[int]):
    if not menu_item_ids: # если пусто, то нечего считать,
        return {}, {}, {}, set()

    from sqlalchemy import func

    # статистика по отзывам для всех блюд сразу.
    agg = (
        db.query(
            Review.menu_item_id,
            func.avg(Review.rating).label("avg_rating"),
            func.count(Review.id).label("cnt"),
        )
        .filter(Review.menu_item_id.in_(menu_item_ids))
        .group_by(Review.menu_item_id)
        .all()
    )
    avg_map = {mid: float(a or 0) for mid, a, c in agg}
    cnt_map = {mid: int(c or 0) for mid, a, c in agg}

    # моя оценка
    mine = (
        db.query(Review.menu_item_id, Review.rating)
        .filter(
            Review.user_id == current_user.id,
            Review.menu_item_id.in_(menu_item_ids),
        )
        .all()
    )
    my_map = {mid: int(r or 0) for mid, r in mine}

    # когда-либо заказывал
    ordered = (
        db.query(MenuDayItem.menu_item_id)
        .join(Order, Order.menu_day_item_id == MenuDayItem.id)
        .filter(
            Order.user_id == current_user.id,
            MenuDayItem.menu_item_id.in_(menu_item_ids),
            Order.status != "CANCELLED",
        )
        .distinct()
        .all()
    )
    eligible = {mid for (mid,) in ordered}

    return avg_map, cnt_map, my_map, eligible


def _get_menu_draft(): #черновик выбора ученика в браузере, если неь то создаем пустой
    return session.setdefault("menu_draft", {})


#черновик на день
def _get_day_draft(menu_date: str):
    draft = _get_menu_draft()
    return draft.setdefault(menu_date, {})

# добавляем выбранное блюдо в черновик
def _set_selection(menu_date: str, meal_type: str, mdi_id: int):
    day = _get_day_draft(menu_date)
    day.setdefault(meal_type, [])
    # на всякий: если вдруг там лежит int от старой версии — приводим к списку
    if isinstance(day[meal_type], int):
        day[meal_type] = [day[meal_type]]
    if mdi_id not in day[meal_type]:
        day[meal_type].append(mdi_id)
    session.modified = True

# убираем блюдо из черновика
def _remove_selection(menu_date: str, meal_type: str, mdi_id: int):
    draft = _get_menu_draft()
    day = draft.get(menu_date)
    if not day:
        return

    cur = day.get(meal_type, [])
    if isinstance(cur, int):
        cur = [cur]

    if mdi_id in cur:
        cur.remove(mdi_id)

    if cur:
        day[meal_type] = cur
    else:
        day.pop(meal_type, None)

    if not day:
        draft.pop(menu_date, None)

    session.modified = True


#cчитает сколько заказов у ученика на выбранную дату чтобы понять уже заказал или нет
def _existing_orders_count(db, user_id: int, selected_date: date) -> int:
    return (
        db.query(Order)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .filter(
            Order.user_id == user_id,
            MenuDay.menu_date == selected_date,
        )
        .count()
    )

#tсли заказ уже есть достаем какие позиции реально заказаны.
def _locked_selected_ids(db, user_id: int, selected_date: date) -> dict:
    selected = {"BREAKFAST": [], "LUNCH": []}
    rows = (
        db.query(MenuDay.meal_type, MenuDayItem.id)
        .join(MenuDayItem, MenuDayItem.menu_day_id == MenuDay.id)
        .join(Order, Order.menu_day_item_id == MenuDayItem.id)
        .filter(
            Order.user_id == user_id,
            MenuDay.menu_date == selected_date,
        )
        .all()
    )
    for mt, mdi_id in rows:
        selected.setdefault(mt, []).append(mdi_id)
    return selected
    

# грузим опубликованное меню на день + приём пищи и собираем все поля: описание, цена, флаги, аллергены, рейтинги
def _load_published_meal_items(db, selected_date: date, meal_type: str):
    menu_day = (
        db.query(MenuDay)
        .options(joinedload(MenuDay.items).joinedload(MenuDayItem.menu_item))
        .filter(
            MenuDay.menu_date == selected_date,
            MenuDay.meal_type == meal_type,
            MenuDay.is_published.is_(True),
        )
        .one_or_none()
    )

    if not menu_day:
        return []

    menu_item_ids = [mdi.menu_item_id for mdi in menu_day.items if mdi.menu_item_id]
    avg_map, cnt_map, my_map, eligible = _rating_maps_for_menu_items(db, menu_item_ids)

    user_allergens = set(getattr(current_user, "allergen_flags", []) or [])

    items = []
    for mdi in menu_day.items:
        mi = mdi.menu_item

        item_allergens = set(mi.allergen_flags or [])
        forbidden = bool(item_allergens & user_allergens)

        avg_rating = float(avg_map.get(mi.id, 0.0) or 0.0)
        reviews_count = int(cnt_map.get(mi.id, 0) or 0)
        my_rating = my_map.get(mi.id)  # int|None
        can_rate = (mi.id in eligible) and (my_rating is None)

        items.append(
            {
                "menu_day_item_id": mdi.id,
                "menu_item_id": mi.id,
                "name": mi.name,
                "description": mi.description,
                "price": mi.price,
                "diet_flags": mi.diet_flags or [],
                "allergen_flags": mi.allergen_flags or [],
                "forbidden": forbidden,

                # рейтинги (как в student_menu)
                "avg_rating": avg_rating,
                "reviews_count": reviews_count,
                "my_rating": my_rating,
                "can_rate": can_rate,
            }
        )

    return items


#uлавная ученика - меню, выбор, календарь
@pages_bp.get("/student/menu")
@login_required
def student_menu():
    if not _has_role(current_user, "student"):
        flash("Доступ запрещён: требуется роль student", "danger")
        return redirect(url_for("pages.index"))

    db = g.db

    # выбранная дата
    date_str = (request.args.get("date") or "").strip()
    if date_str:
        try:
            selected_date = datetime.strptime(date_str, "%Y-%m-%d").date()
        except ValueError:
            selected_date = date.today()
            flash("Некорректная дата, показано меню на сегодня", "warning")
    else:
        selected_date = date.today()

    # список дат (может пригодиться где-то ещё)
    date_options = [date.today() + timedelta(days=i) for i in range(0, 7)]

        # блокируем выбор, если уже есть заказ
    existing_orders_count = (
        db.query(Order)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .filter(
            Order.user_id == current_user.id,
            MenuDay.menu_date == selected_date,
        )
        .count()
    )
    locked = existing_orders_count > 0
    locked_selected = (
        _locked_selected_ids(db, current_user.id, selected_date)
        if locked
        else {"BREAKFAST": [], "LUNCH": []}
    )

    # --- статус заказов на выбранную дат
    existing_statuses = (
        db.query(Order.status)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .filter(
            Order.user_id == current_user.id,
            MenuDay.menu_date == selected_date,
        )
        .all()
    )
    st_list = [(s[0] or "").upper() for s in existing_statuses]
    existing_orders_status = None
    if st_list:
        if all(s == "ISSUED" for s in st_list):
            existing_orders_status = "ISSUED"
        elif all(s in {"PAID", "ISSUED"} for s in st_list):
            existing_orders_status = "PAID"
        else:
            existing_orders_status = "CREATED"

    # если заказ уже есть — показываем его состав
    locked_breakfast = []
    locked_lunch = []
    locked_total_breakfast = 0.0
    locked_total_lunch = 0.0

    if locked:
        order_rows = (
            db.query(Order, MenuDay.meal_type, MenuItem)
            .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
            .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
            .join(MenuItem, MenuItem.id == MenuDayItem.menu_item_id)
            .filter(
                Order.user_id == current_user.id,
                MenuDay.menu_date == selected_date,
                Order.status != "CANCELLED",
            )
            .all()
        )

        for o, meal_type, mi in order_rows:
            item = {
                "order_id": o.id,
                "name": mi.name,
                "price": float(mi.price or 0),
                "status": (o.status or "").upper(),
            }
            if meal_type == "BREAKFAST":
                locked_breakfast.append(item)
                locked_total_breakfast += item["price"]
            else:
                locked_lunch.append(item)
                locked_total_lunch += item["price"]
    # меню показываем только если нет заказа

    if locked:
        breakfast_items = []
        lunch_items = []
    else:
        breakfast_items = _load_published_meal_items(db, selected_date, "BREAKFAST")
        lunch_items = _load_published_meal_items(db, selected_date, "LUNCH")


    # --- календарь: доступные даты (только будни и опубликовано) ---
    enabled_dates = [
        d[0].isoformat()
        for d in (
            db.query(MenuDay.menu_date)
            .filter(MenuDay.is_published.is_(True))
            .distinct()
            .order_by(MenuDay.menu_date)
            .all()
        )
        if d[0].weekday() < 5
    ]

    # --- календарь: даты, где у пользователя уже есть заказы (только будни) ---
    ordered_dates = [
        d[0].isoformat()
        for d in (
            db.query(MenuDay.menu_date)
            .join(MenuDayItem, MenuDayItem.menu_day_id == MenuDay.id)
            .join(Order, Order.menu_day_item_id == MenuDayItem.id)
            .filter(Order.user_id == current_user.id)
            .distinct()
            .order_by(MenuDay.menu_date)
            .all()
        )
        if d[0].weekday() < 5
    ]

    # --- статусы по дням для календаря: created/paid/issued ---
    rows = (
        db.query(MenuDay.menu_date, Order.status)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .filter(Order.user_id == current_user.id)
        .all()
    )

    tmp = {}
    for d, st in rows:
        iso_d = d.isoformat()
        tmp.setdefault(iso_d, []).append((st or "").upper())

    day_status = {}
    for iso_d, statuses in tmp.items():
        statuses = [s for s in statuses if s]
        if statuses and all(s == "ISSUED" for s in statuses):
            day_status[iso_d] = "issued"
        elif statuses and all(s in {"PAID", "ISSUED"} for s in statuses):
            day_status[iso_d] = "paid"
        else:
            day_status[iso_d] = "created"

    # --- выберем дату, с которой календарь должен стартовать ---
    today = date.today()
    future_enabled = [
        iso_d for iso_d in enabled_dates
        if date.fromisoformat(iso_d) >= today
    ]
    first_selectable_date = future_enabled[0] if future_enabled else None

    return render_template(
        "student/menu.html",
        selected_date=selected_date,
        date_options=date_options,
        breakfast_items=breakfast_items,
        lunch_items=lunch_items,
        enabled_dates_json=json.dumps(enabled_dates),
        ordered_dates_json=json.dumps(ordered_dates),
        first_selectable_date=first_selectable_date,
        existing_orders_count=existing_orders_count,
        existing_orders_status=existing_orders_status,
        locked=locked,
        locked_selected=locked_selected,
        day_status_json=json.dumps(day_status),
        allergen_labels=ALLERGEN_LABELS_RU,

        
        locked_breakfast=locked_breakfast,
        locked_lunch=locked_lunch,
        locked_total_breakfast=locked_total_breakfast,
        locked_total_lunch=locked_total_lunch,
        locked_total=(locked_total_breakfast + locked_total_lunch),
    )

#когда ученик нажал “выбрать блюдо”  кладем в черновик
@pages_bp.post("/student/menu/select")
@login_required
def student_menu_select():
    try:
        log.info("HTMX select form=%r headers.HX=%r session_draft=%r",
         dict(request.form), request.headers.get("HX-Request"), session.get("menu_draft"))

        if not _has_role(current_user, "student"):
            abort(403)

        menu_date_str = request.form.get("date")
        meal_type = request.form.get("meal_type")
        mdi_id = request.form.get("menu_day_item_id", type=int)

        if not all([menu_date_str, meal_type, mdi_id]):
            abort(400)

        try:
            selected_date = datetime.strptime(menu_date_str, "%Y-%m-%d").date()
        except ValueError:
            abort(400)

        db = g.db
        existing_orders_count = _existing_orders_count(db, current_user.id, selected_date)
        locked = existing_orders_count > 0
        if locked:
            abort(409)

        mdi = (
            db.query(MenuDayItem)
            .options(
                joinedload(MenuDayItem.menu_day),
                joinedload(MenuDayItem.menu_item),
            )
            .filter(MenuDayItem.id == mdi_id)
            .one_or_none()
        )
        if not mdi or not mdi.menu_day:
            abort(404)

        if mdi.menu_day.menu_date != selected_date:
            abort(400)

        if mdi.menu_day.meal_type != meal_type:
            abort(400)

        # сохраняем выбор в draft
        _set_selection(menu_date_str, meal_type, mdi_id)

        # обновляем блоки
        breakfast_items = _load_published_meal_items(db, selected_date, "BREAKFAST")
        lunch_items = _load_published_meal_items(db, selected_date, "LUNCH")

        html_block = render_template(
            "student/_meal_block.html",
            selected_date=selected_date,
            meal_type=meal_type,
            breakfast_items=breakfast_items,
            lunch_items=lunch_items,
            existing_orders_count=existing_orders_count,
            locked=locked,
            locked_selected={"BREAKFAST": [], "LUNCH": []},
            allergen_labels=ALLERGEN_LABELS_RU,
        )

        html_summary = render_template(
            "student/_summary_oob.html",
            selected_date=selected_date,
            breakfast_items=breakfast_items,
            lunch_items=lunch_items,
            existing_orders_count=existing_orders_count,
            locked=locked,
            locked_selected={"BREAKFAST": [], "LUNCH": []},
            allergen_labels=ALLERGEN_LABELS_RU,
        )

        return html_block + html_summary

    except Exception:
        # Печатает полный traceback в консоль werkzeug/flask
        log.exception("student_menu_select failed")
        raise


#то же самое, но наоборот - “убрать из выбора”
@pages_bp.post("/student/menu/unselect")
@login_required
def student_menu_unselect():
    try:
        if not _has_role(current_user, "student"):
            abort(403)

        log.info("HTMX select form=%r headers.HX=%r session_draft=%r",
         dict(request.form), request.headers.get("HX-Request"), session.get("menu_draft"))

        menu_date_str = request.form.get("date")
        meal_type = request.form.get("meal_type")
        mdi_id = request.form.get("menu_day_item_id", type=int)

        if not all([menu_date_str, meal_type, mdi_id]):
            abort(400)

        try:
            selected_date = datetime.strptime(menu_date_str, "%Y-%m-%d").date()
        except ValueError:
            abort(400)

        _remove_selection(menu_date_str, meal_type, mdi_id)

        db = g.db
        existing_orders_count = _existing_orders_count(db, current_user.id, selected_date)
        locked = existing_orders_count > 0
        if locked:
            abort(409)

        breakfast_items = _load_published_meal_items(db, selected_date, "BREAKFAST")
        lunch_items = _load_published_meal_items(db, selected_date, "LUNCH")


        html_block = render_template(
            "student/_meal_block.html",
            selected_date=selected_date,
            meal_type=meal_type,
            breakfast_items=breakfast_items,
            lunch_items=lunch_items,
            existing_orders_count=existing_orders_count,
            locked=locked,
            locked_selected={"BREAKFAST": [], "LUNCH": []},
            allergen_labels=ALLERGEN_LABELS_RU,
        )

        html_summary = render_template(
            "student/_summary_oob.html",
            selected_date=selected_date,
            breakfast_items=breakfast_items,
            lunch_items=lunch_items,
            existing_orders_count=existing_orders_count,
            locked=locked,
            locked_selected={"BREAKFAST": [], "LUNCH": []},
            allergen_labels=ALLERGEN_LABELS_RU,
        )

        return html_block + html_summary

    except Exception:
        log.exception("student_menu_unselect failed")
        raise

## подтверждение заказа
@pages_bp.post("/student/menu/confirm")
@login_required
def student_menu_confirm():
    if not _has_role(current_user, "student"):
        abort(403)

    menu_date_str = (request.form.get("date") or "").strip()
    if not menu_date_str:
        abort(400)

    try:
        selected_date = datetime.strptime(menu_date_str, "%Y-%m-%d").date()
    except ValueError:
        abort(400)

    # нельзя оформлять заказ в прошлое
    if selected_date < date.today():
        flash("Нельзя оформить заказ на прошедшую дату", "warning")
        return redirect(url_for("pages.student_menu", date=menu_date_str))

    draft = session.get("menu_draft", {}) or {}
    day = draft.get(menu_date_str)

    if not day:
        flash("Ничего не выбрано", "warning")
        return redirect(url_for("pages.student_menu", date=menu_date_str))

    db = g.db

    # если заказ уже есть — на оплату
    existing_count = _existing_orders_count(db, current_user.id, selected_date)
    if existing_count > 0:
        flash("Заказ на эту дату уже создан", "info")
        return redirect(url_for("pages.student_pay", date=menu_date_str))  # если роута pay ещё нет — временно student_menu

    created_any = False

    # проверка даты
    for meal_type, mdi_ids in (day or {}).items():
        if isinstance(mdi_ids, int):
            mdi_ids = [mdi_ids]

        for mdi_id in (mdi_ids or []):
            mdi = (
                db.query(MenuDayItem)
                .options(joinedload(MenuDayItem.menu_day))
                .filter(MenuDayItem.id == int(mdi_id))
                .one_or_none()
            )
            if not mdi or not mdi.menu_day:
                continue

            # защита: mdi должен соответствовать выбранной дате
            if mdi.menu_day.menu_date != selected_date:
                continue

            # защита: тип приёма пищи должен совпадать (если в draft ключи BREAKFAST/LUNCH)
            if (mdi.menu_day.meal_type or "").upper() != (meal_type or "").upper():
                continue

            # защита: меню должно быть опубликовано
            if not bool(getattr(mdi.menu_day, "is_published", False)):
                continue

            order = Order(
                user_id=current_user.id,
                menu_day_item_id=mdi.id,
                status="CREATED",
            )
            db.add(order)
            created_any = True

    if not created_any:
        flash("Не удалось оформить заказ: выбранные позиции недоступны", "warning")
        return redirect(url_for("pages.student_menu", date=menu_date_str))

    db.commit()

    # чистим draft на эту дату
    draft.pop(menu_date_str, None)
    session["menu_draft"] = draft
    session.modified = True

    flash("Заказ создан. Требуется оплата.", "warning")
    return redirect(url_for("pages.student_pay", date=menu_date_str))


# страница оплаты за заказы на выбранную дату.Собирает список заказов, делит на завтрак/обед и считает сумму. определяет уже было оплачено или уже выдано — тогда кнопка оплаты не нужна
@pages_bp.get("/student/pay")
@login_required
def student_pay():
    if not _has_role(current_user, "student"):
        abort(403)

    date_str = (request.args.get("date") or "").strip()
    if not date_str:
        abort(400)

    try:
        selected_date = datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError:
        abort(400)

    db = g.db

    # все заказы пользователя на выбранную дату
    orders = (
        db.query(Order)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .options(joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_item),
                 joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_day))
        .filter(
            Order.user_id == current_user.id,
            MenuDay.menu_date == selected_date,
        )
        .order_by(MenuDay.meal_type, Order.id)
        .all()
    )

    if not orders:
        flash("Нет заказа на выбранную дату", "warning")
        return redirect(url_for("pages.student_menu", date=date_str))

    # считаем суммы по приёмам пищи + итог
    breakfast = []
    lunch = []
    total = 0.0

    for o in orders:
        mdi = o.menu_day_item
        mi = mdi.menu_item
        price = float(mi.price or 0)
        total += price
        row = {
            "order_id": o.id,
            "name": mi.name,
            "price": price,
            "status": (o.status or "").upper(),
            "meal_type": (mdi.menu_day.meal_type or "").upper(),
        }
        if row["meal_type"] == "BREAKFAST":
            breakfast.append(row)
        else:
            lunch.append(row)

    statuses = {(o.status or "").upper() for o in orders}
    # если уже оплачено/выдано — кнопка оплаты не нужна
    is_paid = all(s in {"PAID", "ISSUED"} for s in statuses)
    is_issued = all(s == "ISSUED" for s in statuses)

    return render_template(
        "student/pay.html",
        selected_date=selected_date,
        breakfast=breakfast,
        lunch=lunch,
        total=total,
        is_paid=is_paid,
        is_issued=is_issued,
        balance=float(getattr(current_user, "balance", 0) or 0),
    )

#реально проводит оплату либо с баланса, либо карты (заглушка)
@pages_bp.post("/student/pay")
@login_required
def student_pay_post():
    if not _has_role(current_user, "student"):
        abort(403)

    date_str = (request.form.get("date") or "").strip()
    method = (request.form.get("method") or "").strip()  # balance | card

    if not date_str or method not in {"balance", "card"}:
        abort(400)

    try:
        selected_date = datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError:
        abort(400)

    db = g.db

    # Забираем заказы на дату + цены (нужны для payments)
    orders = (
        db.query(Order)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .options(
            joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_item),
            joinedload(Order.menu_day_item).joinedload(MenuDayItem.menu_day),
            joinedload(Order.payment),
        )
        .filter(
            Order.user_id == current_user.id,
            MenuDay.menu_date == selected_date,
        )
        .all()
    )

    if not orders:
        flash("Нет заказа для оплаты на выбранную дату", "warning")
        return redirect(url_for("pages.student_menu", date=date_str))

    # Если уже оплачено/выдано — не трогаем
    statuses = {(o.status or "").upper() for o in orders}
    if all(s in {"PAID", "ISSUED"} for s in statuses):
        flash("Заказ уже оплачен", "info")
        return redirect(url_for("pages.student_menu", date=date_str))

    # Считаем total по всем CREATED (чтобы не списывать повторно)
    total = 0.0
    payable_orders = []
    for o in orders:
        st = (o.status or "").upper()
        if st != "CREATED":
            continue
        price = float((o.menu_day_item.menu_item.price or 0))
        total += price
        payable_orders.append((o, price))

    if not payable_orders:
        flash("Нет позиций, ожидающих оплаты", "info")
        return redirect(url_for("pages.student_menu", date=date_str))

    # оплата с абонемента
    if method == "balance":
        bal = float(getattr(current_user, "balance", 0) or 0)
        if bal < total:
            flash("Недостаточно средств на абонементе", "danger")
            return redirect(url_for("pages.student_pay", date=date_str))

        # списываем
        current_user.balance = bal - total

        # создаём payments + переводим статусы
        for o, price in payable_orders:
            o.status = "PAID"
            if o.payment is None:
                db.add(Payment(
                    user_id=current_user.id,
                    order_id=o.id,
                    amount=price,
                    payment_type="ORDER_BALANCE",
                ))

        db.commit()
        return redirect(url_for(
            "pages.student_pay_success",
            date=date_str,
            method="balance",
            amount=f"{total:.2f}",
            balance=f"{float(current_user.balance or 0):.2f}",
        ))


    #оплата картой
    else:  # method == "card"
        for o, price in payable_orders:
            o.status = "PAID"
            if o.payment is None:
                db.add(Payment(
                    user_id=current_user.id,
                    order_id=o.id,
                    amount=price,
                    payment_type="ORDER_EXTERNAL",
                ))

        db.commit()
        return redirect(url_for(
            "pages.student_pay_success",
            date=date_str,
            method="card",
            amount=f"{total:.2f}",
        ))

# просто страничка “успешно оплатили”
@pages_bp.get("/student/pay/success")
@login_required
def student_pay_success():
    if not _has_role(current_user, "student"):
        abort(403)

    date_str = (request.args.get("date") or "").strip()
    method = (request.args.get("method") or "").strip()  # balance | card
    amount_str = (request.args.get("amount") or "").strip()
    balance_str = (request.args.get("balance") or "").strip()

    if not date_str or method not in {"balance", "card"}:
        abort(400)

    try:
        selected_date = datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError:
        abort(400)

    # amount/balance приходят строками из url, превращаем в float безопасно
    try:
        amount = float(amount_str) if amount_str else 0.0
    except ValueError:
        amount = 0.0

    try:
        new_balance = float(balance_str) if balance_str else None
    except ValueError:
        new_balance = None

    return render_template(
        "student/pay_success.html",
        selected_date=selected_date,
        method=method,
        amount=amount,
        new_balance=new_balance,
    )

#Ставит оценку блюду или обновляет ее
@pages_bp.post("/student/review")
@login_required
def student_review_create_or_update():
    if not _has_role(current_user, "student"):
        abort(403)

    menu_item_id = request.form.get("menu_item_id", type=int)
    rating = request.form.get("rating", type=int)

    if not menu_item_id or not rating or rating < 1 or rating > 5:
        abort(400)

    db = g.db

    # Проверяем, что пользователь когда-либо заказывал это блюдо
    ordered = (
        db.query(Order.id)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .filter(
            Order.user_id == current_user.id,
            MenuDayItem.menu_item_id == menu_item_id,
            Order.status != "CANCELLED",
        )
        .first()
    )
    if not ordered:
        abort(403)

    # upsert review (уникальность можно обеспечить логикой, даже без constraint)
    rev = (
        db.query(Review)
        .filter(
            Review.user_id == current_user.id,
            Review.menu_item_id == menu_item_id,
        )
        .one_or_none()
    )
    if rev:
        rev.rating = rating
    else:
        rev = Review(user_id=current_user.id, menu_item_id=menu_item_id, rating=rating)
        db.add(rev)

    db.commit()

    
    from sqlalchemy import func
    agg = (
        db.query(func.avg(Review.rating), func.count(Review.id))
        .filter(Review.menu_item_id == menu_item_id)
        .one()
    )
    avg_rating = float(agg[0] or 0.0)
    reviews_count = int(agg[1] or 0)

    return render_template(
        "student/_rating_inline.html",
        avg_rating=avg_rating,
        reviews_count=reviews_count,
        my_rating=rating,
        can_rate=False,
        menu_item_id=menu_item_id,
    )


# показывает историю заказов ученика, группирует по датам и по приемам пищи, считает суммы.
@pages_bp.get("/student/orders")
@login_required
def student_orders():
    if not _has_role(current_user, "student"):
        flash("Доступ запрещён: требуется роль student", "danger")
        return redirect(url_for("pages.index"))

    db = g.db

    rows = (
        db.query(
            Order.id,
            Order.status,
            Order.created_at,
            MenuDay.menu_date,
            MenuDay.meal_type,
            MenuItem.name,
            MenuItem.price,
        )
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .join(MenuItem, MenuItem.id == MenuDayItem.menu_item_id)
        .filter(Order.user_id == current_user.id)
        .order_by(MenuDay.menu_date.desc(), MenuDay.meal_type.asc(), Order.created_at.asc())
        .all()
    )

    # группировка по датам
    by_date = {}

    def _ru_meal(meal_type: str) -> str:
        return "Завтрак" if (meal_type or "").upper() == "BREAKFAST" else "Обед"

    def _status_rank(st: str) -> int:
        # чем меньше — тем "хуже/раньше" статус (для агрегирования)
        st = (st or "").upper()
        if st == "CREATED":
            return 1
        if st == "PAID":
            return 2
        if st == "ISSUED":
            return 3
        if st == "CANCELLED":
            return 0
        return 1

    def _aggregate_status(statuses: list[str]) -> str:
        # Если есть CREATED -> CREATED
        # Иначе если есть PAID -> PAID
        # Иначе если все ISSUED -> ISSUED
        # CANCELLED отдельно (если все отменены)
        up = [(s or "").upper() for s in statuses if s]
        if not up:
            return "CREATED"
        if all(s == "CANCELLED" for s in up):
            return "CANCELLED"
        if any(s == "CREATED" for s in up):
            return "CREATED"
        if any(s == "PAID" for s in up):
            return "PAID"
        if all(s == "ISSUED" for s in up):
            return "ISSUED"
        # на всякий случай
        return sorted(up, key=_status_rank)[0]

    for (_oid, st, _created_at, mdate, meal_type, item_name, item_price) in rows:
        iso = mdate.isoformat()
        rec = by_date.setdefault(
            iso,
            {
                "date": mdate,
                "meals": {},   # meal_type -> dict
                "total": 0.0,
                "statuses": [],
            },
        )

        meal_type_u = (meal_type or "").upper()
        meal = rec["meals"].setdefault(
            meal_type_u,
            {
                "title": _ru_meal(meal_type_u),
                "items": [],
                "total": 0.0,
                "statuses": [],
            },
        )

        price = float(item_price or 0)
        meal["items"].append({"name": item_name, "price": price})
        meal["total"] += price
        rec["total"] += price

        meal["statuses"].append(st)
        rec["statuses"].append(st)

    # финальные статусы по дате
    order_list = []
    for iso, rec in by_date.items():
        rec["status"] = _aggregate_status(rec["statuses"])
        # Также можно статус по каждому meal:
        for mt, meal in rec["meals"].items():
            meal["status"] = _aggregate_status(meal["statuses"])
        order_list.append(rec)

    # сортировка (на всякий)
    order_list.sort(key=lambda x: x["date"], reverse=True)

    # русские статусы для UI
    status_ru = {
        "CREATED": "Ожидает оплаты",
        "PAID": "Оплачено",
        "ISSUED": "Выдано",
        "CANCELLED": "Отменено",
    }

    return render_template(
        "student/orders.html",
        orders=order_list,
        status_ru=status_ru,
    )

# страница профиля ученика, тут в основном выбор аллергенов.
@pages_bp.get("/student/profile")
@login_required
def student_profile():
    if not _has_role(current_user, "student"):
        abort(403)

    return render_template(
        "student/profile.html",
        allergen_labels=ALLERGEN_LABELS_RU,
    )

#форма выбора аллергенов (чекбоксы)
@pages_bp.get("/student/profile/allergens")
@login_required
def student_profile_allergens():
    if not _has_role(current_user, "student"):
        abort(403)

    # показываем все возможные аллерген-флаги
    all_flags = list(ALLERGEN_LABELS_RU.keys())
    return render_template(
        "student/profile_allergens.html",
        all_flags=all_flags,
        selected=set(current_user.allergen_flags or []),
        allergen_labels=ALLERGEN_LABELS_RU,   # ← ДОБАВИТЬ
    )

#cохраняет выбранные аллергены ученика в бд
@pages_bp.post("/student/profile/allergens")
@login_required
def student_profile_allergens_save():
    if not _has_role(current_user, "student"):
        abort(403)

    db = g.db
    flags = request.form.getlist("allergens")  # чекбоксы
    current_user.allergen_flags = flags
    db.add(current_user)
    db.commit()

    flash("Аллергены обновлены", "success")
    return redirect(url_for("pages.student_profile"))


# показывает историю оплат (payments) ученика
@pages_bp.get("/student/payments")
@login_required
def student_payments():
    if not _has_role(current_user, "student"):
        abort(403)

    db = g.db  

    payments = (
        db.query(Payment)
        .options(
            joinedload(Payment.order)
            .joinedload(Order.menu_day_item)
            .joinedload(MenuDayItem.menu_day),

            joinedload(Payment.order)
            .joinedload(Order.menu_day_item)
            .joinedload(MenuDayItem.menu_item),
        )
        .filter(Payment.user_id == current_user.id)
        .order_by(Payment.created_at.desc())
        .all()
    )

    type_ru = {
        "TOPUP": "Пополнение баланса",
        "ORDER_BALANCE": "Оплата с баланса",
        "ORDER_EXTERNAL": "Оплата картой",
    }

    meal_ru = {
        "BREAKFAST": "Завтрак",
        "LUNCH": "Обед",
    }

    groups_map = {}

    def _get_group(key, title, menu_date=None):
        grp = groups_map.get(key)
        if grp is None:
            grp = {
                "key": key,
                "title": title,
                "menu_date": menu_date,
                "items": [],
                "total": 0.0,
            }
            groups_map[key] = grp
        return grp

    for p in payments:
        has_order = (
            p.order is not None
            and p.order.menu_day_item is not None
            and p.order.menu_day_item.menu_day is not None
        )

        if has_order:
            md = p.order.menu_day_item.menu_day
            menu_date = md.menu_date
            key = ("DAY", menu_date.isoformat())
            title = menu_date.strftime("%d.%m.%Y")
            grp = _get_group(key, title, menu_date=menu_date)
        else:
            key = ("TOPUP", "TOPUP")
            grp = _get_group(key, "Пополнения баланса", menu_date=None)

        grp["items"].append(p)
        grp["total"] += float(p.amount or 0)

    day_groups = [x for x in groups_map.values() if x["menu_date"] is not None]
    topup_groups = [x for x in groups_map.values() if x["menu_date"] is None]

    day_groups.sort(key=lambda x: x["menu_date"], reverse=True)
    payment_groups = day_groups + topup_groups

    return render_template(
        "student/payments.html",
        payment_groups=payment_groups,
        type_ru=type_ru,
        meal_ru=meal_ru,
    )




# показывает мои отзывы/оценки по блюдам
@pages_bp.get("/student/reviews")
@login_required
def student_my_reviews():
    if not _has_role(current_user, "student"):
        abort(403)

    db = g.db

    reviews = (
        db.query(Review)
        .options(joinedload(Review.menu_item))
        .filter(Review.user_id == current_user.id)
        .order_by(Review.created_at.desc())
        .all()
    )

    return render_template("student/my_reviews.html", reviews=reviews)

