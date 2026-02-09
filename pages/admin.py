import logging
from datetime import datetime, date


import bcrypt
from flask import abort, flash, g, redirect, render_template, request, url_for
from flask_login import current_user, login_required
from sqlalchemy.orm import joinedload
from sqlalchemy import func, tuple_, case

from models import (
    User,
    Role,
    Payment,
    Order,
    UserRole,
    MenuDay,
    MenuDayItem,
    PurchaseRequest,
    PurchaseRequestItem,
    Ingredient,
)

from .common import _has_role, pages_bp

log = logging.getLogger("ui_auth")

ALLOWED_ROLE_NAMES = {"admin", "cook", "student"}


def _require_admin():
    if not _has_role(current_user, "admin"):
        abort(403)


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


def _hash_password(password: str) -> str:
    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
    return hashed.decode("utf-8")


def _normalize_roles_from_form(values: list[str]) -> list[str]:
    # В админке роли редактируем только для сотрудников (cook/admin).
    # student тут не принимаем вообще.
    out: list[str] = []
    seen = set()
    for v in values:
        r = (v or "").strip().lower()
        if r not in {"cook", "admin"}:
            continue
        if r not in seen:
            out.append(r)
            seen.add(r)
    return out


    
def _fmt_dt(dt) -> str:
    if not dt:
        return "—"
    # без микросекунд
    return dt.strftime("%Y-%m-%d %H:%M")


_PR_STATUS_RU = {
    "CREATED": "Ожидает одобрения",
    "APPROVED": "Одобрена",
    "REJECTED": "Отклонена",
    "COMPLETED": "Выполнена",
    "CANCELLED": "Отменена",
}


def _pr_status_ru(s: str | None) -> str:
    key = (s or "").strip().upper()
    return _PR_STATUS_RU.get(key, key or "—")

#Считает сумму заявки по позициям.
def _pr_total_sum(pr: PurchaseRequest) -> float:
    total = 0.0
    for it in (pr.items or []):
        ing = it.ingredient
        if not ing:
            continue

        pack_qty = float(getattr(ing, "purchase_pack_qty", 0) or 0)
        pack_price = float(getattr(ing, "purchase_pack_price", 0) or 0)
        qty = float(getattr(it, "qty", 0) or 0)

        if pack_qty > 0 and pack_price > 0:
            total += (qty / pack_qty) * pack_price

    return float(total)

def _user_label(u) -> str:
    if not u:
        return "—"
    first = (getattr(u, "first_name", "") or "").strip()
    last = (getattr(u, "last_name", "") or "").strip()
    full = (f"{first} {last}").strip()
    if full:
        return full
    email = (getattr(u, "email", "") or "").strip()
    return email or "—"




@pages_bp.get("/admin/dashboard")
@login_required
def admin_dashboard():
    _require_admin()
    db = g.db

    date_from = _parse_date(request.args.get("date_from"))
    date_to = _parse_date(request.args.get("date_to"))

    # по умолчанию показываем текущий месяц
    if not date_from and not date_to:
        today = datetime.utcnow().date()
        date_from = today.replace(day=1)
        date_to = today

    # всего учеников
    total_students = (
        db.query(func.count(func.distinct(User.id)))
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
        .filter(func.lower(Role.name) == "student")
        .scalar()
        or 0
    )

    # оплаты еды (ученики)
    food_pay_q = (
        db.query(Payment)
        .filter(Payment.order_id.isnot(None))
        .join(Order, Order.id == Payment.order_id)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .join(User, User.id == Payment.user_id)
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
        .filter(func.lower(Role.name) == "student")
    )
    if date_from:
        food_pay_q = food_pay_q.filter(MenuDay.menu_date >= date_from)
    if date_to:
        food_pay_q = food_pay_q.filter(MenuDay.menu_date <= date_to)

    # куплено блюд
    bought_dishes = food_pay_q.count()

    # сумма
    bought_sum = food_pay_q.with_entities(func.coalesce(func.sum(Payment.amount), 0)).scalar() or 0

    # сколько учеников вообще покупало еду (уникальные)
    paid_students = food_pay_q.with_entities(func.count(func.distinct(Payment.user_id))).scalar() or 0

    # уникальные оплаты по (ученик + дата меню)
    paid_events = (
        food_pay_q.with_entities(func.count(func.distinct(tuple_(Payment.user_id, MenuDay.menu_date))))
        .scalar()
        or 0
    )

    # отдельно: баланс / карта
    balance_q = food_pay_q.filter(Payment.payment_type == "ORDER_BALANCE")
    card_q = food_pay_q.filter(Payment.payment_type == "ORDER_EXTERNAL")

    balance_dishes = balance_q.count()
    balance_sum = balance_q.with_entities(func.coalesce(func.sum(Payment.amount), 0)).scalar() or 0
    balance_students = balance_q.with_entities(func.count(func.distinct(Payment.user_id))).scalar() or 0
    balance_events = (
        balance_q.with_entities(func.count(func.distinct(tuple_(Payment.user_id, MenuDay.menu_date))))
        .scalar()
        or 0
    )

    card_dishes = card_q.count()
    card_sum = card_q.with_entities(func.coalesce(func.sum(Payment.amount), 0)).scalar() or 0
    card_students = card_q.with_entities(func.count(func.distinct(Payment.user_id))).scalar() or 0
    card_events = (
        card_q.with_entities(func.count(func.distinct(tuple_(Payment.user_id, MenuDay.menu_date))))
        .scalar()
        or 0
    )

   #пополнения баланса
    dt_from = datetime.combine(date_from, datetime.min.time()) if date_from else None
    dt_to = datetime.combine(date_to, datetime.max.time()) if date_to else None

    topup_q = (
        db.query(Payment)
        .filter(Payment.payment_type == "TOPUP")
        .join(User, User.id == Payment.user_id)
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
        .filter(func.lower(Role.name) == "student")
    )
    if dt_from:
        topup_q = topup_q.filter(Payment.created_at >= dt_from)
    if dt_to:
        topup_q = topup_q.filter(Payment.created_at <= dt_to)

    topup_count = topup_q.count()
    topup_sum = topup_q.with_entities(func.coalesce(func.sum(Payment.amount), 0)).scalar() or 0
    topup_students = topup_q.with_entities(func.count(func.distinct(Payment.user_id))).scalar() or 0

   #питание по дням
    orders_base = (
        db.query(Order)
        .join(MenuDayItem, MenuDayItem.id == Order.menu_day_item_id)
        .join(MenuDay, MenuDay.id == MenuDayItem.menu_day_id)
        .join(User, User.id == Order.user_id)
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
        .filter(func.lower(Role.name) == "student")
    )
    if date_from:
        orders_base = orders_base.filter(MenuDay.menu_date >= date_from)
    if date_to:
        orders_base = orders_base.filter(MenuDay.menu_date <= date_to)

    ordered_students_any = (
        orders_base.filter(Order.status != "CANCELLED")
        .with_entities(func.count(func.distinct(Order.user_id)))
        .scalar()
        or 0
    )

    issued_students_any = (
        orders_base.filter(Order.status == "ISSUED")
        .with_entities(func.count(func.distinct(Order.user_id)))
        .scalar()
        or 0
    )

    ordered_positions_total = (
        orders_base.filter(Order.status != "CANCELLED")
        .with_entities(func.count(Order.id))
        .scalar()
        or 0
    )

    issued_positions_total = (
        orders_base.filter(Order.status == "ISSUED")
        .with_entities(func.count(Order.id))
        .scalar()
        or 0
    )

    day_rows_q = (
        db.query(
            MenuDay.menu_date.label("menu_date"),
            func.count(func.distinct(Order.user_id)).filter(Order.status != "CANCELLED").label("students_ordered"),
            func.count(func.distinct(Order.user_id)).filter(Order.status == "ISSUED").label("students_issued"),
        )
        .join(MenuDayItem, MenuDayItem.menu_day_id == MenuDay.id)
        .join(Order, Order.menu_day_item_id == MenuDayItem.id)
        .join(User, User.id == Order.user_id)
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
        .filter(func.lower(Role.name) == "student")
    )
    if date_from:
        day_rows_q = day_rows_q.filter(MenuDay.menu_date >= date_from)
    if date_to:
        day_rows_q = day_rows_q.filter(MenuDay.menu_date <= date_to)

    day_rows_raw = day_rows_q.group_by(MenuDay.menu_date).order_by(MenuDay.menu_date).all()
    day_rows = [{"menu_date": d, "ordered": int(o or 0), "issued": int(i or 0)} for d, o, i in day_rows_raw]

    return render_template(
        "admin/dashboard.html",
        date_from=date_from.isoformat() if date_from else "",
        date_to=date_to.isoformat() if date_to else "",

        total_students=int(total_students),

        # оплаты еды
        paid_students=int(paid_students),
        bought_dishes=int(bought_dishes),
        paid_events=int(paid_events),
        bought_sum=float(bought_sum),

        balance_students=int(balance_students),
        balance_dishes=int(balance_dishes),
        balance_events=int(balance_events),
        balance_sum=float(balance_sum),

        card_students=int(card_students),
        card_dishes=int(card_dishes),
        card_events=int(card_events),
        card_sum=float(card_sum),

        # пополнения
        topup_students=int(topup_students),
        topup_count=int(topup_count),
        topup_sum=float(topup_sum),

        # питание
        ordered_students_any=int(ordered_students_any),
        issued_students_any=int(issued_students_any),
        ordered_positions_total=int(ordered_positions_total),
        issued_positions_total=int(issued_positions_total),
        day_rows=day_rows,
    )


# заявки на закупку (админ)
@pages_bp.get("/admin/purchase-requests")
@login_required
def admin_purchase_requests():
    _require_admin()
    db = g.db

    status = (request.args.get("status") or "").strip().upper()
    if status and status not in {"CREATED", "APPROVED", "REJECTED", "COMPLETED", "CANCELLED"}:
        status = ""

    q = (
        db.query(PurchaseRequest)
        .options(
            joinedload(PurchaseRequest.created_by),
            joinedload(PurchaseRequest.items).joinedload(PurchaseRequestItem.ingredient),
        )
        .order_by(PurchaseRequest.created_at.desc())
    )

    if status:
        q = q.filter(PurchaseRequest.status == status)

    prs = q.all()

    rows = []
    for pr in prs:
        creator = pr.created_by
        creator_label = _user_label(creator)

        rows.append({
            "id": int(pr.id),
            "created_at": _fmt_dt(pr.created_at),
            "status": (pr.status or "").upper(),
            "status_ru": _pr_status_ru(pr.status),
            "creator": creator_label,
            "total_sum": _pr_total_sum(pr),
        })

    return render_template(
        "admin/purchase_requests.html",
        status=status,
        rows=rows,
    )


@pages_bp.post("/admin/purchase-requests/<int:pr_id>/approve")
@login_required
def admin_purchase_request_approve(pr_id: int):
    _require_admin()
    db = g.db

    pr = db.get(PurchaseRequest, pr_id)
    if not pr:
        abort(404)

    if (pr.status or "").upper() != "CREATED":
        flash("Можно согласовать только заявку со статусом «Ожидает одобрения»", "warning")
        if request.headers.get("HX-Request") == "true":
            return ("", 204)
        return redirect(url_for("pages.admin_purchase_requests"))

    pr.status = "APPROVED"
    db.commit()

    flash(f"Заявка #{pr.id} согласована", "success")
    if request.headers.get("HX-Request") == "true":
        return ("", 204, {"HX-Trigger": "pr-updated"})
    return redirect(url_for("pages.admin_purchase_requests"))


@pages_bp.post("/admin/purchase-requests/<int:pr_id>/reject")
@login_required
def admin_purchase_request_reject(pr_id: int):
    _require_admin()
    db = g.db

    pr = db.get(PurchaseRequest, pr_id)
    if not pr:
        abort(404)

    if (pr.status or "").upper() != "CREATED":
        flash("Можно отклонить только заявку со статусом «Ожидает одобрения»", "warning")
        if request.headers.get("HX-Request") == "true":
            return ("", 204)
        return redirect(url_for("pages.admin_purchase_requests"))

    pr.status = "REJECTED"
    db.commit()

    flash(f"Заявка #{pr.id} отклонена", "success")
    if request.headers.get("HX-Request") == "true":
        return ("", 204, {"HX-Trigger": "pr-updated"})
    return redirect(url_for("pages.admin_purchase_requests"))


# отчёты
@pages_bp.get("/admin/reports")
@login_required
def admin_reports():
    _require_admin()
    db = g.db

    date_from = _parse_date(request.args.get("date_from"))
    date_to = _parse_date(request.args.get("date_to"))

    # текущий месяц
    if not date_from and not date_to:
        today = datetime.utcnow().date()
        date_from = today.replace(day=1)
        date_to = today

    # питание: сколько заказано/оплачено/выдано
    food_q = (
        db.query(
            MenuDay.meal_type.label("meal_type"),
            func.coalesce(
                func.sum(case((Order.status != "CANCELLED", 1), else_=0)),
                0,
            ).label("ordered_cnt"),
            func.coalesce(
                func.sum(case((Order.status.in_(["PAID", "ISSUED"]), 1), else_=0)),
                0,
            ).label("paid_cnt"),
            func.coalesce(
                func.sum(case((Order.status == "ISSUED", 1), else_=0)),
                0,
            ).label("issued_cnt"),
        )
        .select_from(MenuDay)
        .join(MenuDayItem, MenuDayItem.menu_day_id == MenuDay.id)
        .join(Order, Order.menu_day_item_id == MenuDayItem.id)
    )

    if date_from:
        food_q = food_q.filter(MenuDay.menu_date >= date_from)
    if date_to:
        food_q = food_q.filter(MenuDay.menu_date <= date_to)

    food_rows = food_q.group_by(MenuDay.meal_type).all()

    food_map = {}
    for mt, ordered_cnt, paid_cnt, issued_cnt in food_rows:
        food_map[str(mt)] = {
            "ordered": int(ordered_cnt or 0),
            "paid": int(paid_cnt or 0),
            "issued": int(issued_cnt or 0),
        }

    def _get(mt: str, k: str) -> int:
        return int((food_map.get(mt) or {}).get(k, 0) or 0)

    ordered_breakfast = _get("BREAKFAST", "ordered")
    paid_breakfast = _get("BREAKFAST", "paid")
    issued_breakfast = _get("BREAKFAST", "issued")

    ordered_lunch = _get("LUNCH", "ordered")
    paid_lunch = _get("LUNCH", "paid")
    issued_lunch = _get("LUNCH", "issued")


    #закупки
    def _purchase_cost_for_status(status: str) -> float:
        q = (
            db.query(
                func.coalesce(
                    func.sum(
                        func.ceil(PurchaseRequestItem.qty / Ingredient.purchase_pack_qty)
                        * Ingredient.purchase_pack_price
                    ),
                    0,
                )
            )
            .select_from(PurchaseRequestItem)
            .join(PurchaseRequest, PurchaseRequest.id == PurchaseRequestItem.purchase_request_id)
            .join(Ingredient, Ingredient.id == PurchaseRequestItem.ingredient_id)
            .filter(PurchaseRequest.status == status)
        )
        if date_from:
            q = q.filter(PurchaseRequest.created_at >= datetime.combine(date_from, datetime.min.time()))
        if date_to:
            q = q.filter(PurchaseRequest.created_at < datetime.combine(date_to, datetime.max.time()))
        return float(q.scalar() or 0)

    approved_cost = _purchase_cost_for_status("APPROVED")
    pending_cost = _purchase_cost_for_status("CREATED")

    return render_template(
        "admin/reports.html",
        date_from=date_from.isoformat() if date_from else "",
        date_to=date_to.isoformat() if date_to else "",

        # питание
        ordered_breakfast=ordered_breakfast,
        paid_breakfast=paid_breakfast,
        issued_breakfast=issued_breakfast,

        ordered_lunch=ordered_lunch,
        paid_lunch=paid_lunch,
        issued_lunch=issued_lunch,

        # закупки
        approved_cost=float(approved_cost or 0),
        pending_cost=float(pending_cost or 0),
    )


# пользователи
@pages_bp.get("/admin/users")
@login_required
def admin_users():
    _require_admin()
    db = g.db

    tab = (request.args.get("tab") or "students").strip().lower()
    if tab not in {"students", "cooks", "admins"}:
        tab = "students"

    q = (request.args.get("q") or "").strip().lower()

    base_q = (
        db.query(User)
        .join(UserRole, UserRole.user_id == User.id)
        .join(Role, Role.id == UserRole.role_id)
    )

    role_name = {"students": "student", "cooks": "cook", "admins": "admin"}[tab]
    users_q = base_q.filter(func.lower(Role.name) == role_name).order_by(User.id.asc())

    if q:
        users_q = users_q.filter(
            func.lower(User.email).contains(q)
            | func.lower(User.first_name).contains(q)
            | func.lower(User.last_name).contains(q)
        )

    users = users_q.all()

    return render_template(
        "admin/users.html",
        users=users,
        q=q,
        tab=tab,
    )

@pages_bp.get("/admin/users/create/<role_key>")
@login_required
def admin_users_create_form(role_key: str):
    _require_admin()
    role_key = (role_key or "").strip().lower()
    if role_key not in {"student", "cook", "admin"}:
        abort(404)

    return render_template("admin/user_create.html", fixed_role=role_key)


@pages_bp.route("/admin/users/create/<role_key>", methods=["POST"])
@login_required
def admin_users_create(role_key: str):
    # доступ только админам
    if not _has_role(current_user, "admin"):
        abort(403)

    role_key = (role_key or "").lower()
    if role_key not in ("student", "cook", "admin"):
        abort(404)

    email = (request.form.get("email") or "").strip().lower()
    first_name = (request.form.get("first_name") or "").strip()
    last_name = (request.form.get("last_name") or "").strip()
    password = request.form.get("password") or ""

    # базовая валидация
    if not email or not first_name or not last_name or len(password) < 6:
        return redirect(url_for("pages.admin_users", tab=f"{role_key}s", error="invalid_input"))

    db = g.db

    # проверяем, что email не занят
    existing = db.query(User).filter(func.lower(User.email) == email).one_or_none()
    if existing:
        return redirect(url_for("pages.admin_users", tab=f"{role_key}s", error="email_exists"))

    # роль ищем по Role.name (так устроено в models.py)
    role = db.query(Role).filter(func.lower(Role.name) == role_key).one_or_none()
    if not role:
        return redirect(url_for("pages.admin_users", tab=f"{role_key}s", error="role_missing"))

    password_hash = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    user = User(
        email=email,
        first_name=first_name,
        last_name=last_name,
        password_hash=password_hash,
    )
    user.roles.append(role)

    try:
        db.add(user)
        db.commit()
    except Exception:
        db.rollback()
        return redirect(url_for("pages.admin_users", tab=f"{role_key}s", error="db_error"))

    return redirect(url_for("pages.admin_users", tab=f"{role_key}s", created=email))




@pages_bp.get("/admin/users/<int:user_id>")
@login_required
def admin_user_edit_form(user_id: int):
    _require_admin()
    db = g.db

    user = db.get(User, user_id)
    if not user:
        abort(404)

    all_roles = db.query(Role).order_by(Role.name.asc()).all()
    user_roles = {r.name for r in (user.roles or [])}

    return render_template(
        "admin/user_edit.html",
        user=user,
        all_roles=all_roles,
        user_roles=user_roles,
    )


@pages_bp.post("/admin/users/<int:user_id>")
@login_required
def admin_user_edit_save(user_id: int):
    _require_admin()
    db = g.db

    user = db.get(User, user_id)
    if not user:
        abort(404)

    email = (request.form.get("email") or "").strip().lower()
    first_name = (request.form.get("first_name") or "").strip()
    last_name = (request.form.get("last_name") or "").strip()
    password = (request.form.get("password") or "").strip()

    # студенту роли не меняем
    is_student = any((r.name or "").lower() == "student" for r in (user.roles or []))

    # в админке для сотрудников принимаем только cook/admin
    role_names = _normalize_roles_from_form(request.form.getlist("roles"))

    # базовые поля
    if not email or not first_name or not last_name:
        flash("Заполните e-mail, имя и фамилию", "danger")
        return redirect(url_for("pages.admin_user_edit_form", user_id=user_id))

    user.email = email
    user.first_name = first_name
    user.last_name = last_name

    # роли
    if is_student:
        # студент: роли фиксированы, не меняем
        pass
    else:
        # сотрудник: минимум одна роль (повар и/или админ)
        if not role_names:
            flash("У сотрудника должна быть хотя бы одна роль (повар и/или админ)", "danger")
            return redirect(url_for("pages.admin_user_edit_form", user_id=user_id))

        roles = db.query(Role).filter(Role.name.in_(role_names)).all()
        user.roles = roles

    # пароль (можно менять всем)
    if password:
        if len(password) < 6:
            flash("Новый пароль должен быть не короче 6 символов", "danger")
            return redirect(url_for("pages.admin_user_edit_form", user_id=user_id))
        user.password_hash = _hash_password(password)

    db.add(user)
    try:
        db.commit()
    except Exception:
        db.rollback()
        flash("Не удалось сохранить пользователя (возможно, e-mail уже существует)", "danger")
        return redirect(url_for("pages.admin_user_edit_form", user_id=user_id))

    flash("Пользователь обновлён", "success")
    # возвращаемся на вкладку по фактической роли
    if is_student:
        return redirect(url_for("pages.admin_users", tab="students"))
    if any((r.name or "").lower() == "admin" for r in (user.roles or [])) and not any((r.name or "").lower() == "cook" for r in (user.roles or [])):
        return redirect(url_for("pages.admin_users", tab="admins"))
    return redirect(url_for("pages.admin_users", tab="cooks"))



@pages_bp.get("/admin/purchase-requests/<int:pr_id>/details")
@login_required
def admin_purchase_request_details(pr_id: int):
    _require_admin()
    db = g.db

    pr = (
        db.query(PurchaseRequest)
        .options(
            joinedload(PurchaseRequest.created_by),
            joinedload(PurchaseRequest.items).joinedload(PurchaseRequestItem.ingredient),
        )
        .filter(PurchaseRequest.id == pr_id)
        .first()
    )
    if not pr:
        abort(404)

    creator = pr.created_by
    creator_label = _user_label(creator)

    items = []
    total_sum = 0.0

    for it in (pr.items or []):
        ing = it.ingredient
        if not ing:
            continue

        qty = float(it.qty or 0)
        unit = (ing.unit or "").strip()
        pack_qty = float(getattr(ing, "purchase_pack_qty", 0) or 0)
        pack_price = float(getattr(ing, "purchase_pack_price", 0) or 0)

        packs_f = (qty / pack_qty) if pack_qty > 0 else 0.0
        subtotal = (packs_f * pack_price) if pack_price > 0 else 0.0
        total_sum += subtotal

        items.append({
            "name": ing.name,
            "qty": qty,
            "unit": unit,
            "pack_qty": pack_qty,
            "pack_price": pack_price,
            "packs_f": packs_f,
            "subtotal": subtotal,
        })

    return render_template(
        "admin/_purchase_request_details.html",
        pr_id=int(pr.id),
        created_at=_fmt_dt(pr.created_at),
        creator=creator_label,
        status=(pr.status or "").upper(),
        status_ru=_pr_status_ru(pr.status),
        comment=(pr.comment or "").strip(),
        total_sum=float(total_sum),
        items=items,
    )
