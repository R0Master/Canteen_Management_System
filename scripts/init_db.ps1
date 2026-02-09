$ErrorActionPreference = "Stop"

$dbName = "kitchen_backend_test"
$dbUser = "postgres"
$dbHost = "localhost"

Write-Host "== Инициализация БД: $dbName =="

$createdb = Get-Command createdb -ErrorAction SilentlyContinue
$psql     = Get-Command psql     -ErrorAction SilentlyContinue

if (-not $createdb -or -not $psql) {
  Write-Host "Не найдены утилиты PostgreSQL (createdb/psql) в PATH." -ForegroundColor Red
  Write-Host "Добавьте путь к bin PostgreSQL (например: C:\Program Files\PostgreSQL\16\bin) в PATH." -ForegroundColor Yellow
  exit 1
}

try {
  createdb -h $dbHost -U $dbUser $dbName
  Write-Host "База создана."
} catch {
  Write-Host "База уже существует — продолжаем."
}

psql -h $dbHost -U $dbUser -d $dbName -f db\schema.sql
psql -h $dbHost -U $dbUser -d $dbName -f db\seed.sql

Write-Host "Готово. База данных инициализирована."
