import logging
import traceback

from flask import Blueprint, render_template, request, redirect, url_for, g
from flask import flash
from flask_login import login_user, logout_user, current_user
from flask import Response

from sqlalchemy import func
from sqlalchemy.orm import joinedload

from auth import _verify_password
from models import User


pages_bp = Blueprint("pages", __name__)

log = logging.getLogger("ui_auth")


# ловит все ошибки если что-то пошло не так
@pages_bp.errorhandler(Exception)
def pages_any_exception(e):
    # Печатаем ПОЛНЫЙ traceback в консоль
    log.exception("Unhandled exception in pages blueprint")
    # Для HTMX вернём текст ошибки прямо в ответ, чтобы видеть в браузере
    if request.headers.get("HX-Request") == "true":
        tb = traceback.format_exc()
        return Response(tb, status=500, mimetype="text/plain")
    # Для обычных запросов — пусть Flask debugger показывает красивую страницу
    raise e


# проверяем есть ли у пользователя нужная роль
def _has_role(user, role: str) -> bool:
    role = (role or "").lower()
    uid = getattr(user, "id", None)
    if not uid:
        return False

    db = getattr(g, "db", None)
    if db is None:
        # fallback: как было (на всякий случай)
        return any((getattr(r, "name", "") or "").lower() == role for r in getattr(user, "roles", []))

    # грузим user вместе с roles 
    u = (
        db.query(User)
        .options(joinedload(User.roles))
        .filter(User.id == uid)
        .one_or_none()
    )
    if not u:
        return False

    return any((getattr(r, "name", "") or "").lower() == role for r in (u.roles or []))
    

# куда кидать пользователя после логина
def _post_login_redirect(user):
    # student
    if _has_role(user, "student"):
        return redirect(url_for("pages.student_menu"))
    # cook
    if _has_role(user, "cook"):
        return redirect(url_for("pages.cook_dashboard"))
    # admin (если есть)
    if _has_role(user, "admin"):
        return redirect(url_for("pages.admin_dashboard"))
    # fallback
    return redirect(url_for("pages.index"))


# главная страница сайта
@pages_bp.get("/")
def index():
    if getattr(current_user, "is_authenticated", False):
        return _post_login_redirect(current_user)
    return render_template("base.html")

#обрабатывает логин по email и паролю
@pages_bp.post("/login")
def login():
    email_raw = request.form.get("email") or ""
    email = email_raw.strip()
    password = request.form.get("password") or ""

    log.info("UI LOGIN attempt: email=%r", email)

    if not email or not password:
        log.warning("UI LOGIN failed: missing email or password")
        flash("Введите e-mail и пароль", "danger")
        return redirect(url_for("pages.index"))

    db = g.db
    email_lc = email.lower()
    user = db.query(User).filter(func.lower(User.email) == email_lc).one_or_none()

    if not user:
        log.warning("UI LOGIN failed: user not found: email=%r", email)
        flash("Неверный e-mail или пароль", "danger")
        return redirect(url_for("pages.index"))

    if not _verify_password(password, user.password_hash):
        log.warning("UI LOGIN failed: bad password: user_id=%s email=%r", user.id, user.email)
        flash("Неверный e-mail или пароль", "danger")
        return redirect(url_for("pages.index"))

    login_user(user)
    log.info("UI LOGIN success: user_id=%s email=%r", user.id, user.email)
    return _post_login_redirect(user)


#выйти из системы
@pages_bp.post("/logout")
def logout():
    uid = getattr(current_user, "id", None)
    logout_user()
    log.info("UI LOGOUT: user_id=%r", uid)
    return redirect(url_for("pages.index"))

