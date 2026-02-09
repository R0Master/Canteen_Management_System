# pages/units.py
from __future__ import annotations

from dataclasses import dataclass
from math import ceil
from typing import Tuple


# нормализует единицы измерения (г, мл, шт)
def unit_ru(unit: str | None) -> str:
    u = (unit or "").strip().lower()
    if u in {"g", "г"}:
        return "г"
    if u in {"ml", "мл"}:
        return "мл"
    if u in {"pcs", "шт"}:
        return "шт"
    return (unit or "").strip()


# единицы для отображения на складе (г->кг, мл->л)
def stock_unit_h(unit: str | None) -> str:
    u = (unit or "").strip().lower()
    if u in {"g", "г"}:
        return "кг"
    if u in {"ml", "мл"}:
        return "л"
    if u in {"pcs", "шт"}:
        return "шт"
    return (unit or "").strip()


# формат числа без лишних нулей
def fmt_number(x: float | int | None) -> str:
    if x is None:
        return "0"
    v = float(x)
    if abs(v - round(v)) < 1e-9:
        return str(int(round(v)))
    s = f"{v:.3f}".rstrip("0").rstrip(".")
    return s


# перевод количества в складские единицы
def to_stock_human(qty_base: float, unit_base: str) -> Tuple[float, str]:
    u = (unit_base or "").strip().lower()
    if u in {"g", "г"}:
        return (qty_base / 1000.0, "кг")
    if u in {"ml", "мл"}:
        return (qty_base / 1000.0, "л")
    if u in {"pcs", "шт"}:
        return (qty_base, "шт")
    return (qty_base, unit_base)


# формат количества для отображения на складе
def fmt_stock_qty(qty_base: float, unit_base: str) -> tuple[str, str]:
    v, u = to_stock_human(float(qty_base or 0), unit_base)
    if u in {"кг", "л"}:
        return (f"{v:.2f}".rstrip("0").rstrip("."), u)
    return (fmt_number(v), u)


# рекомендуемое количество упаковок
def default_packs(need_base: float, pack_qty_base: float) -> int:
    if need_base <= 0:
        return 0
    pq = pack_qty_base if pack_qty_base and pack_qty_base > 0 else 1.0
    return int(ceil(need_base / pq))


# строка для отображения позиции закупки
@dataclass
class PurchaseViewRow:
    name: str
    packs: int
    pack_label: str
    need_label: str
    buy_label: str


# подпись упаковки (для закупок)
def fmt_pack_label(pack_qty_base: float, unit_base: str) -> str:
    u = (unit_base or "").strip().lower()
    pack = float(pack_qty_base or 0)

    if u in {"g", "г"}:
        if pack >= 1000:
            return f"{fmt_number(pack / 1000)} кг"
        return f"{fmt_number(pack)} г"

    if u in {"ml", "мл"}:
        if pack >= 1000:
            return f"{fmt_number(pack / 1000)} л"
        return f"{fmt_number(pack)} мл"

    if u in {"pcs", "шт"}:
        return f"{fmt_number(pack)} шт"

    return f"{fmt_number(pack)} {unit_base}"


# подпись потребности (не упаковки)
def fmt_need_label(need_base: float, unit_base: str) -> str:
    v, u = to_stock_human(float(need_base or 0), unit_base)
    return f"{fmt_number(v)} {u}"


# подпись итоговой покупки
def fmt_buy_label(packs: int, pack_qty_base: float, unit_base: str) -> str:
    total = float(packs or 0) * float(pack_qty_base or 0)
    v, u = to_stock_human(total, unit_base)
    return f"{fmt_number(v)} {u}"


# человекочитаемые статусы заявок
def status_ru(status: str | None) -> str:
    s = (status or "").upper()
    if s == "CREATED":
        return "Ожидает одобрения"
    if s == "APPROVED":
        return "Одобрена"
    if s == "REJECTED":
        return "Отклонена"
    if s == "CANCELLED":
        return "Отменена"
    return status or "—"
