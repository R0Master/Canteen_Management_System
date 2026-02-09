from __future__ import annotations

from functools import wraps
from typing import Callable, Optional, TypeVar, Any, cast

import bcrypt
from flask import Blueprint, request, g
from flask_login import current_user, login_user, logout_user

from utils import ok, error
from models import User

auth_bp = Blueprint("auth", __name__, url_prefix="/api/auth")

F = TypeVar("F", bound=Callable[..., Any])


# берём текущую сессию БД из g
def _get_db():
    db = getattr(g, "db", None)
    if db is None:
        raise RuntimeError("DB session is not initialized. Ensure app.py sets g.db in before_request.")
    return db


# текущий пользователь (через Flask-Login)
def get_current_user() -> Optional[User]:
    if getattr(current_user, "is_authenticated", False):
        return cast(User, current_user)
    return None


# декоратор: чтобы API возвращал JSON, а не редиректы
def login_required(fn: F) -> F:
    @wraps(fn)
    def wrapper(*args, **kwargs):
        user = get_current_user()
        if not user:
            return error("Unauthorized", status=401, code="unauthorized")
        g.current_user = user
        return fn(*args, **kwargs)
    return cast(F, wrapper)


# доступ только для указанных ролей
def roles_required(*allowed_roles: str) -> Callable[[F], F]:
    allowed = set(r.lower() for r in allowed_roles)

    def decorator(fn: F) -> F:
        @wraps(fn)
        def wrapper(*args, **kwargs):
            user = get_current_user()
            if not user:
                return error("Unauthorized", status=401, code="unauthorized")

            user_role_names = {r.name.lower() for r in user.roles}
            if not (user_role_names & allowed):
                return error("Forbidden", status=403, code="forbidden", details={"required": list(allowed)})

            g.current_user = user
            return fn(*args, **kwargs)
        return cast(F, wrapper)

    return decorator


# проверка пароля (bcrypt), плюс обработка кривого формата "b'...'"
def _verify_password(password: str, password_hash: str) -> bool:
    try:
        ph = (password_hash or "").strip()

        if ph.startswith("b'") and ph.endswith("'"):
            ph = ph[2:-1]
        elif ph.startswith('b"') and ph.endswith('"'):
            ph = ph[2:-1]

        return bcrypt.checkpw(password.encode("utf-8"), ph.encode("utf-8"))
    except Exception:
        return False


# логин по email и паролю
@auth_bp.post("/login")
def login():
    payload = request.get_json(silent=True) or {}
    email = (payload.get("email") or "").strip().lower()
    password = payload.get("password") or ""

    if not email or not password:
        return error(
            "Необходимо указать e-mail и пароль",
            status=400,
            code="bad_request",
        )

    db = _get_db()
    user: Optional[User] = db.query(User).filter(User.email == email).one_or_none()

    if not user or not _verify_password(password, user.password_hash):
        return error(
            "Неверный e-mail или пароль",
            status=401,
            code="invalid_credentials",
        )

    # логиним через Flask-Login
    login_user(user)

    return ok(
        {
            "id": user.id,
            "email": user.email,
            "first_name": getattr(user, "first_name", None),
            "last_name": getattr(user, "last_name", None),
            "roles": [r.name for r in user.roles],
        }
    )


# выход из аккаунта
@auth_bp.post("/logout")
def logout():
    logout_user()
    return ok({"logout": True})


# информация о текущем пользователе
@auth_bp.get("/me")
@login_required
def me():
    user: User = g.current_user
    return ok(
        {
            "id": user.id,
            "email": user.email,
            "first_name": getattr(user, "first_name", None),
            "last_name": getattr(user, "last_name", None),
            "diet_flags": user.diet_flags,
            "allergen_flags": user.allergen_flags,
            "roles": [r.name for r in user.roles],
            "created_at": user.created_at.isoformat() if user.created_at else None,
        }
    )
