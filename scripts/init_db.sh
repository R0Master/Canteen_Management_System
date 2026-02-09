#!/usr/bin/env bash
set -e

DB_NAME="kitchen_backend_test"
DB_USER="postgres"
DB_HOST="localhost"

echo "== Инициализация БД: $DB_NAME =="

if ! command -v createdb >/dev/null 2>&1 || ! command -v psql >/dev/null 2>&1; then
  echo "Ошибка: утилиты PostgreSQL (createdb/psql) не найдены в PATH."
  echo "Убедитесь, что PostgreSQL установлен и bin добавлен в PATH."
  exit 1
fi

createdb -h "$DB_HOST" -U "$DB_USER" "$DB_NAME" || echo "База уже существует — продолжаем."
psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f db/schema.sql
psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f db/seed.sql

echo "Готово. База данных инициализирована."
