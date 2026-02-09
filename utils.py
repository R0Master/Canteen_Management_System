from typing import Any, Dict, Optional
from flask import jsonify

# названия аллергенов по-русски
ALLERGEN_LABELS_RU = {
    "MILK": "Молоко",
    "EGGS": "Яйца",
    "FISH": "Рыба",
    "NUTS": "Орехи",
    "PEANUTS": "Арахис",
    "GLUTEN": "Глютен",
    "SOY": "Соя",
}


# успешный JSON-ответ
def ok(data: Any = None, status: int = 200, **meta: Any):
    payload: Dict[str, Any] = {"ok": True, "data": data}
    if meta:
        payload["meta"] = meta
    return jsonify(payload), status


# JSON-ответ с ошибкой
def error(
    message: str,
    status: int = 400,
    code: str = "bad_request",
    details: Any = None,
):
    payload: Dict[str, Any] = {
        "ok": False,
        "error": {
            "code": code,
            "message": message,
        },
    }
    if details is not None:
        payload["error"]["details"] = details
    return jsonify(payload), status


# разбирает строку из env вида "a,b,c"
def parse_csv_env(value: Optional[str]) -> list[str]:
    if not value:
        return []
    return [x.strip() for x in value.split(",") if x.strip()]


# перевод HTTP-кода в текст ошибки
def http_error_code(status: int) -> str:
    return {
        400: "bad_request",
        401: "unauthorized",
        403: "forbidden",
        404: "not_found",
        409: "conflict",
        422: "unprocessable_entity",
        500: "internal_error",
    }.get(status, "error")
