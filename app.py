import os
import logging
from urllib.parse import urlsplit, urlunsplit
from contextlib import contextmanager
from typing import Generator, Optional
from sqlalchemy.orm import selectinload


from dotenv import load_dotenv
from flask import Flask, g, request
from flask_cors import CORS
from flask_login import LoginManager, current_user
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.exc import SQLAlchemyError

from utils import ok, error, parse_csv_env, http_error_code

from models import User

from auth import auth_bp
from pages.common import pages_bp
import pages.student
import pages.cook
import pages.admin

# env и логирование
load_dotenv()
logging.basicConfig(level=logging.INFO)


def _mask_dsn(dsn: str) -> str:
    # маскирует пароль в строке подключения
    try:
        parts = urlsplit(dsn)
        if parts.username or parts.password:
            netloc = parts.hostname or ""
            if parts.port:
                netloc += f":{parts.port}"
            if parts.username:
                netloc = f"{parts.username}:***@{netloc}"
            dsn = urlunsplit((parts.scheme, netloc, parts.path, parts.query, parts.fragment))
        return dsn
    except Exception:
        return "<invalid dsn>"


def get_env(name: str, default: str) -> str:
    # берём переменную окружения, если нет — default
    return os.getenv(name, default)


def db_diagnostics(engine) -> None:
    # простая проверка базы при старте (коннект + есть ли таблица users)
    logger = logging.getLogger("db")
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))

            users_exists = conn.execute(
                text("SELECT to_regclass('public.users') IS NOT NULL")
            ).scalar()

            users_count = None
            if users_exists:
                users_count = conn.execute(text("SELECT COUNT(*) FROM users")).scalar()

        logger.info("DB: подключение есть")
        logger.info("DB: таблица users %s", "есть" if users_exists else "не найдена")
        if users_exists:
            logger.info("DB: пользователей в users = %s", users_count)
        else:
            logger.warning("DB: похоже, схема не применена (см. schema.sql)")
    except Exception as e:
        logger.exception("DB: ошибка подключения: %s", e)


def create_app() -> Flask:
    app = Flask(__name__)

    # настройки
    app.config["ENV"] = get_env("FLASK_ENV", "development")
    app.config["DEBUG"] = get_env("FLASK_DEBUG", "1") == "1"
    app.config["SECRET_KEY"] = get_env("SECRET_KEY", "dev-secret-key")

    app.config["DATABASE_URL"] = get_env(
        "DATABASE_URL",
        "postgresql+psycopg2://postgres:postgres@localhost:5432/kitchen_backend",
    )

    # база
    engine = create_engine(
        app.config["DATABASE_URL"],
        pool_pre_ping=True,
        future=True,
    )

    dsn_to_show = _mask_dsn(str(engine.url))
    logging.getLogger("db").info("DB: url = %s", dsn_to_show)
    db_diagnostics(engine)

    SessionLocal = sessionmaker(
        bind=engine,
        autoflush=False,
        autocommit=False,
        future=True,
    )

    app.engine = engine
    app.SessionLocal = SessionLocal

    # логин
    login_manager = LoginManager()
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id: str):
        try:
            uid = int(user_id)
        except Exception:
            return None

        db = SessionLocal()
        try:
            # роли подтягиваем сразу
            user = db.get(User, uid, options=(selectinload(User.roles),))
            return user
        finally:
            db.close()

    # роуты
    app.register_blueprint(auth_bp)
    app.register_blueprint(pages_bp)


    # чтобы в шаблонах был current_user
    @app.context_processor
    def inject_current_user():
        return {"current_user": current_user}

    # сессия БД на запрос
    @app.before_request
    def open_db_session():
        g.db = SessionLocal()

    @app.teardown_request
    def close_db_session(exc: Optional[BaseException] = None):
        db: Optional[Session] = getattr(g, "db", None)
        if not db:
            return
        try:
            if exc is None:
                db.commit()
            else:
                db.rollback()
        finally:
            db.close()

    @contextmanager
    def db_session() -> Generator[Session, None, None]:
        db = SessionLocal()
        try:
            yield db
            db.commit()
        except Exception:
            db.rollback()
            raise
        finally:
            db.close()

    app.db_session = db_session


    # обработка ошибок
    @app.errorhandler(400)
    def bad_request(e):
        return error("Bad request", 400, http_error_code(400), getattr(e, "description", None))

    @app.errorhandler(401)
    def unauthorized(e):
        if _is_api_request():
            return error("Unauthorized", 401, http_error_code(401))
        return "Unauthorized", 401

    @app.errorhandler(403)
    def forbidden(e):
        if _is_api_request():
            return error("Forbidden", 403, http_error_code(403))
        return "Forbidden", 403

    @app.errorhandler(404)
    def not_found(e):
        if _is_api_request():
            return error("Not found", 404, http_error_code(404), {"path": request.path})
        return "Not found", 404

    @app.errorhandler(409)
    def conflict(e):
        return error("Conflict", 409, http_error_code(409))

    @app.errorhandler(422)
    def unprocessable(e):
        return error("Unprocessable entity", 422, http_error_code(422))

    @app.errorhandler(500)
    def internal_error(e):
        return error("Internal server error", 500, http_error_code(500))

    @app.errorhandler(Exception)
    def unhandled_exception(e: Exception):
        if app.config["DEBUG"]:
            return error("Unhandled exception", 500, "unhandled_exception", str(e))
        return error("Internal server error", 500, http_error_code(500))

    return app


app = create_app()

if __name__ == "__main__":
    host = get_env("HOST", "0.0.0.0")
    port = int(get_env("PORT", "5001"))
    app.run(host=host, port=port)
