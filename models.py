from __future__ import annotations

from datetime import date, datetime
from typing import List, Optional
from flask_login import UserMixin

from sqlalchemy import (
    String,
    Integer,
    Boolean,
    Date,
    DateTime,
    ForeignKey,
    Numeric,
    Text,
    Enum,
    UniqueConstraint,
)
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


# базовый класс моделей
class Base(DeclarativeBase):
    pass


# enum-типы для Postgres
DietFlagEnum = Enum(
    "VEGETARIAN",
    "VEGAN",
    "HALAL",
    "NO_SUGAR",
    name="diet_flag",
)

AllergenFlagEnum = Enum(
    "MILK",
    "EGGS",
    "FISH",
    "NUTS",
    "PEANUTS",
    "GLUTEN",
    "SOY",
    name="allergen_flag",
)

OrderStatusEnum = Enum(
    "CREATED",
    "PAID",
    "ISSUED",
    "CANCELLED",
    name="order_status",
)

MealTypeEnum = Enum(
    "BREAKFAST",
    "LUNCH",
    name="meal_type",
)

PaymentTypeEnum = Enum(
    "ORDER_BALANCE",    # оплата с баланса
    "ORDER_EXTERNAL",   # оплата картой (или другое внешнее)
    "TOPUP",            # пополнение баланса
    name="payment_type",
)


PurchaseRequestStatusEnum = Enum(
    "CREATED",
    "APPROVED",
    "REJECTED",
    "COMPLETED",
    name="purchase_request_status",
)


# роли
class Role(Base):
    __tablename__ = "roles"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)

    users: Mapped[List["User"]] = relationship(
        secondary="user_roles",
        back_populates="roles",
    )


# пользователь
class User(Base, UserMixin):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)

    first_name: Mapped[str] = mapped_column(String(100), nullable=False)
    last_name: Mapped[str] = mapped_column(String(100), nullable=False)

    diet_flags: Mapped[List[str]] = mapped_column(
        ARRAY(DietFlagEnum),
        default=list,
        nullable=False,
    )
    allergen_flags: Mapped[List[str]] = mapped_column(
        ARRAY(AllergenFlagEnum),
        default=list,
        nullable=False,
    )
    
    balance: Mapped[float] = mapped_column(
        Numeric(10, 2),
        default=0,
        nullable=False,
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime, default=datetime.utcnow
    )

    roles: Mapped[List[Role]] = relationship(
        secondary="user_roles",
        back_populates="users",
    )

    orders: Mapped[List["Order"]] = relationship(back_populates="user")
    reviews: Mapped[List["Review"]] = relationship(back_populates="user")


# связь пользователь-роли (m2m)
class UserRole(Base):
    __tablename__ = "user_roles"

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
    )
    role_id: Mapped[int] = mapped_column(
        ForeignKey("roles.id", ondelete="CASCADE"),
        primary_key=True,
    )


# блюдо из справочника
class MenuItem(Base):
    __tablename__ = "menu_items"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[Optional[str]] = mapped_column(Text)

    price: Mapped[float] = mapped_column(Numeric(10, 2), nullable=False)

    diet_flags: Mapped[List[str]] = mapped_column(
        ARRAY(DietFlagEnum),
        default=list,
        nullable=False,
    )
    allergen_flags: Mapped[List[str]] = mapped_column(
        ARRAY(AllergenFlagEnum),
        default=list,
        nullable=False,
    )

    is_active: Mapped[bool] = mapped_column(Boolean, default=True)

    recipe_items: Mapped[List["MenuItemIngredient"]] = relationship(
        back_populates="menu_item",
        cascade="all, delete-orphan",
    )


# меню на дату и приём пищи
class MenuDay(Base):
    __tablename__ = "menu_days"
    __table_args__ = (
        UniqueConstraint("menu_date", "meal_type"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    menu_date: Mapped[date] = mapped_column(Date, nullable=False)
    meal_type: Mapped[str] = mapped_column(MealTypeEnum, nullable=False)
    is_published: Mapped[bool] = mapped_column(Boolean, default=False)

    items: Mapped[List["MenuDayItem"]] = relationship(back_populates="menu_day")


# позиция меню (ссылка на блюдо)
class MenuDayItem(Base):
    __tablename__ = "menu_day_items"

    id: Mapped[int] = mapped_column(primary_key=True)
    menu_day_id: Mapped[int] = mapped_column(
        ForeignKey("menu_days.id", ondelete="CASCADE"),
        nullable=False,
    )
    menu_item_id: Mapped[int] = mapped_column(
        ForeignKey("menu_items.id"),
        nullable=False,
    )

    menu_day: Mapped[MenuDay] = relationship(back_populates="items")
    menu_item: Mapped[MenuItem] = relationship()


# заказ
class Order(Base):
    __tablename__ = "orders"

    id: Mapped[int] = mapped_column(primary_key=True)

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id"),
        nullable=False,
    )
    menu_day_item_id: Mapped[int] = mapped_column(
        ForeignKey("menu_day_items.id"),
        nullable=False,
    )

    status: Mapped[str] = mapped_column(
        OrderStatusEnum,
        default="CREATED",
        nullable=False,
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime, default=datetime.utcnow
    )
    issued_at: Mapped[Optional[datetime]] = mapped_column(DateTime)

    user: Mapped[User] = relationship(back_populates="orders")
    menu_day_item: Mapped[MenuDayItem] = relationship()
    payment: Mapped[Optional["Payment"]] = relationship(
        back_populates="order",
        uselist=False,
    )


# платежи (оплата заказа / пополнение)
class Payment(Base):
    __tablename__ = "payments"

    id: Mapped[int] = mapped_column(primary_key=True)

    # кто сделал операцию
    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id"),
        nullable=False,
    )

    # если это оплата заказа (иначе NULL)
    order_id: Mapped[int | None] = mapped_column(
        ForeignKey("orders.id"),
        nullable=True,
    )

    # сумма операции
    amount: Mapped[float] = mapped_column(
        Numeric(10, 2),
        nullable=False,
    )

    # тип операции
    payment_type: Mapped[str] = mapped_column(
        PaymentTypeEnum,
        nullable=False,
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime,
        default=datetime.utcnow,
        nullable=False,
    )

    # связи
    user: Mapped["User"] = relationship()
    order: Mapped[Optional["Order"]] = relationship(
        back_populates="payment"
    )


# отзывы/оценки
class Review(Base):
    __tablename__ = "reviews"

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id"),
        nullable=False,
    )
    menu_item_id: Mapped[int] = mapped_column(
        ForeignKey("menu_items.id"),
        nullable=False,
    )

    rating: Mapped[int] = mapped_column(Integer, nullable=False)
    comment: Mapped[Optional[str]] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(
        DateTime, default=datetime.utcnow
    )

    user: Mapped[User] = relationship(back_populates="reviews")
    menu_item: Mapped[MenuItem] = relationship()

# ингредиенты, рецепты, склад, закупки


class Ingredient(Base):
    __tablename__ = "ingredients"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    unit: Mapped[str] = mapped_column(String(50), nullable=False)  # g / ml / pcs / ...
    purchase_pack_qty: Mapped[float] = mapped_column(
        Numeric(12, 3),
        default=1,
        nullable=False,
        comment="Количество базовых единиц в одной закупочной упаковке",
    )
    purchase_pack_price: Mapped[float] = mapped_column(
        Numeric(12, 2),
        nullable=False,
        comment="Цена одной закупочной упаковки",
    )
    is_active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    recipe_links: Mapped[List["MenuItemIngredient"]] = relationship(
        back_populates="ingredient",
        cascade="all, delete-orphan",
    )

    inventory: Mapped[Optional["InventoryIngredient"]] = relationship(
        back_populates="ingredient",
        uselist=False,
        cascade="all, delete-orphan",
    )



class MenuItemIngredient(Base):
    # рецептура: сколько нужно ингредиента на 1 порцию
    # qty_per_portion — в единицах Ingredient.unit
    __tablename__ = "menu_item_ingredients"
    __table_args__ = (
        UniqueConstraint("menu_item_id", "ingredient_id", name="uq_menu_item_ingredient"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)

    menu_item_id: Mapped[int] = mapped_column(
        ForeignKey("menu_items.id", ondelete="CASCADE"),
        nullable=False,
    )
    ingredient_id: Mapped[int] = mapped_column(
        ForeignKey("ingredients.id", ondelete="RESTRICT"),
        nullable=False,
    )

    qty_per_portion: Mapped[float] = mapped_column(Numeric(12, 3), nullable=False)

    menu_item: Mapped["MenuItem"] = relationship(back_populates="recipe_items")
    ingredient: Mapped["Ingredient"] = relationship(back_populates="recipe_links")


class InventoryIngredient(Base):
    # остатки по ингредиенту (в единицах Ingredient.unit)
    __tablename__ = "inventory_ingredients"

    ingredient_id: Mapped[int] = mapped_column(
        ForeignKey("ingredients.id", ondelete="CASCADE"),
        primary_key=True,
    )

    on_hand: Mapped[float] = mapped_column(Numeric(12, 3), default=0, nullable=False)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, nullable=False)

    ingredient: Mapped["Ingredient"] = relationship(back_populates="inventory")


# заявка на закупку
class PurchaseRequest(Base):
    __tablename__ = "purchase_requests"

    id: Mapped[int] = mapped_column(primary_key=True)

    created_by_user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
    )

    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, nullable=False)

    status: Mapped[str] = mapped_column(
        PurchaseRequestStatusEnum,
        default="CREATED",
        nullable=False,
    )

    comment: Mapped[Optional[str]] = mapped_column(Text)

    items: Mapped[List["PurchaseRequestItem"]] = relationship(
        back_populates="purchase_request",
        cascade="all, delete-orphan",
    )

    created_by: Mapped[Optional["User"]] = relationship()


# позиция заявки на закупку
class PurchaseRequestItem(Base):
    __tablename__ = "purchase_request_items"
    __table_args__ = (
        UniqueConstraint("purchase_request_id", "ingredient_id", name="uq_pr_ingredient"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)

    purchase_request_id: Mapped[int] = mapped_column(
        ForeignKey("purchase_requests.id", ondelete="CASCADE"),
        nullable=False,
    )

    ingredient_id: Mapped[int] = mapped_column(
        ForeignKey("ingredients.id", ondelete="RESTRICT"),
        nullable=False,
    )

    qty: Mapped[float] = mapped_column(Numeric(12, 3), nullable=False)

    purchase_request: Mapped["PurchaseRequest"] = relationship(back_populates="items")
    ingredient: Mapped["Ingredient"] = relationship()
