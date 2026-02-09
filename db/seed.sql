--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (1, 'Картофель', 'г', true, 1000.000, 35.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (2, 'Мясо', 'г', true, 1000.000, 650.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (3, 'Овсяные хлопья', 'г', true, 1000.000, 120.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (4, 'Гречка', 'г', true, 1000.000, 110.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (5, 'Яйца', 'шт', true, 10.000, 90.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (6, 'Молоко', 'мл', true, 1000.000, 80.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (7, 'Сливочное масло', 'г', true, 180.000, 170.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (8, 'Творог', 'г', true, 1000.000, 260.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (9, 'Мука пшеничная', 'г', true, 1000.000, 70.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (10, 'Сметана', 'г', true, 500.000, 120.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (11, 'Хлеб пшеничный', 'г', true, 400.000, 45.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (12, 'Джем', 'г', true, 300.000, 95.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (13, 'Свёкла', 'г', true, 1000.000, 40.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (14, 'Капуста', 'г', true, 1000.000, 35.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (15, 'Морковь', 'г', true, 1000.000, 45.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (16, 'Лук', 'г', true, 1000.000, 40.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (17, 'Томатная паста', 'г', true, 500.000, 110.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (18, 'Чеснок', 'г', true, 100.000, 30.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (19, 'Куриное филе', 'г', true, 1000.000, 480.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (20, 'Панировочные сухари', 'г', true, 1000.000, 85.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (21, 'Рис', 'г', true, 1000.000, 90.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (22, 'Рыба', 'г', true, 1000.000, 420.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (23, 'Макароны', 'г', true, 1000.000, 75.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (24, 'Сыр твёрдый', 'г', true, 1000.000, 620.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (25, 'Огурцы', 'г', true, 1000.000, 110.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (26, 'Помидоры', 'г', true, 1000.000, 120.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (27, 'Зелень', 'г', true, 100.000, 35.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (28, 'Соль', 'г', true, 1000.000, 20.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (29, 'Сахар', 'г', true, 1000.000, 65.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (30, 'Растительное масло', 'мл', true, 1000.000, 140.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (31, 'Вода', 'мл', true, 5000.000, 25.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (33, 'Манная крупа', 'г', true, 1000.000, 85.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (34, 'Лапша', 'г', true, 1000.000, 95.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (35, 'Тыква', 'г', true, 1000.000, 45.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (36, 'Грибы', 'г', true, 1000.000, 160.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (37, 'Перловка', 'г', true, 1000.000, 80.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (38, 'Йогурт', 'г', true, 500.000, 90.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (39, 'Мюсли', 'г', true, 500.000, 130.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (40, 'Яблоко', 'г', true, 1000.000, 95.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (41, 'Банан', 'г', true, 1000.000, 85.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (42, 'Апельсин', 'г', true, 1000.000, 120.00);
INSERT INTO public.ingredients (id, name, unit, is_active, purchase_pack_qty, purchase_pack_price) VALUES (43, 'Сухофрукты', 'г', true, 500.000, 150.00);


--
-- Data for Name: inventory_ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (3, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (5, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (6, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (8, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (10, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (11, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (12, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (13, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (18, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (19, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (22, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (24, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (25, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (26, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (27, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (31, 0.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (35, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (36, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (38, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (39, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (40, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (41, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (42, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (43, 0.000, '2026-02-05 21:03:54.453018');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (2, 5000.000, '2026-02-05 20:54:49.935569');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (4, 7000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (9, 10000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (17, 1500.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (20, 2000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (21, 7000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (23, 8000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (28, 3000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (29, 5000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (33, 4000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (34, 4000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (37, 5000.000, '2026-02-08 18:24:31.809954');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (7, 1500.000, '2026-02-08 18:24:39.056087');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (30, 3000.000, '2026-02-08 18:24:39.056087');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (1, 12000.000, '2026-02-08 18:24:44.414395');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (14, 6000.000, '2026-02-08 18:24:44.414395');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (15, 4000.000, '2026-02-08 18:24:44.414395');
INSERT INTO public.inventory_ingredients (ingredient_id, on_hand, updated_at) VALUES (16, 4000.000, '2026-02-08 18:24:44.414395');


--
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: menu_days; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (1, '2026-01-28', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (2, '2026-01-28', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (3, '2026-01-30', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (4, '2026-01-30', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (5, '2026-01-31', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (6, '2026-01-31', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (7, '2026-02-01', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (8, '2026-02-01', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (9, '2026-02-02', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (10, '2026-02-02', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (11, '2026-02-03', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (12, '2026-02-03', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (13, '2026-02-04', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (14, '2026-02-04', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (15, '2026-02-05', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (16, '2026-02-05', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (17, '2026-02-06', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (18, '2026-02-06', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (39, '2026-02-23', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (40, '2026-02-23', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (41, '2026-02-24', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (42, '2026-02-24', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (43, '2026-02-25', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (44, '2026-02-25', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (45, '2026-02-26', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (46, '2026-02-26', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (79, '2026-02-27', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (80, '2026-02-27', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (81, '2026-03-02', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (82, '2026-03-02', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (83, '2026-03-03', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (84, '2026-03-03', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (85, '2026-03-04', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (86, '2026-03-04', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (87, '2026-03-05', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (88, '2026-03-05', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (89, '2026-03-06', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (90, '2026-03-06', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (19, '2026-02-09', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (21, '2026-02-10', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (23, '2026-02-11', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (25, '2026-02-12', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (27, '2026-02-13', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (96, '2026-02-14', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (97, '2026-02-15', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (29, '2026-02-16', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (31, '2026-02-17', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (33, '2026-02-18', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (35, '2026-02-19', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (37, '2026-02-20', 'BREAKFAST', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (20, '2026-02-09', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (22, '2026-02-10', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (24, '2026-02-11', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (26, '2026-02-12', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (28, '2026-02-13', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (108, '2026-02-14', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (109, '2026-02-15', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (30, '2026-02-16', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (32, '2026-02-17', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (34, '2026-02-18', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (36, '2026-02-19', 'LUNCH', true);
INSERT INTO public.menu_days (id, menu_date, meal_type, is_published) VALUES (38, '2026-02-20', 'LUNCH', true);


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (1, 'Картошка с мясом', 'По-домашнему', 160.00, '{}', '{GLUTEN,MILK}', false);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (2, 'Овсяная каша', 'На молоке', 90.00, '{VEGETARIAN}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (3, 'Гречневая каша', 'Сливочное масло', 85.00, '{VEGETARIAN}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (4, 'Яичница', '2 яйца', 95.00, '{}', '{EGGS}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (5, 'Сырники', 'Со сметаной', 110.00, '{VEGETARIAN}', '{MILK,EGGS,GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (6, 'Тосты с джемом', 'Пшеничный хлеб', 70.00, '{VEGETARIAN}', '{GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (7, 'Борщ', 'Классический', 140.00, '{}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (8, 'Куриная котлета с пюре', 'Пюре на молоке', 170.00, '{}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (9, 'Рыба с рисом', 'Запечённая', 175.00, '{}', '{FISH}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (10, 'Макароны с сыром', 'Сыр твёрдый', 150.00, '{VEGETARIAN}', '{GLUTEN,MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (11, 'Овощной салат', 'Свежие овощи', 90.00, '{VEGAN}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (12, 'Рисовая каша', 'На молоке', 85.00, '{VEGETARIAN}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (13, 'Манная каша', 'На молоке', 80.00, '{VEGETARIAN}', '{MILK,GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (14, 'Омлет', 'Омлет на молоке', 100.00, '{}', '{EGGS,MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (15, 'Блинчики со сметаной', '3 шт.', 115.00, '{VEGETARIAN}', '{GLUTEN,EGGS,MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (16, 'Йогурт с мюсли', 'Натуральный йогурт', 95.00, '{VEGETARIAN}', '{MILK,GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (17, 'Творожная запеканка', 'Со сметаной', 120.00, '{VEGETARIAN}', '{MILK,EGGS,GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (18, 'Фруктовый салат', 'Яблоко, банан, апельсин', 90.00, '{VEGAN}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (19, 'Суп куриный с лапшой', 'Домашняя лапша', 135.00, '{}', '{GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (20, 'Суп-пюре из тыквы', 'Со сливками', 130.00, '{VEGETARIAN}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (21, 'Плов с курицей', 'Рис, курица', 175.00, '{}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (22, 'Тефтели с гречкой', 'Тефтели с гарниром', 180.00, '{}', '{EGGS}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (23, 'Овощная котлета с рисом', 'Постное блюдо', 160.00, '{VEGETARIAN}', '{GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (24, 'Картофельная запеканка', 'С сыром', 165.00, '{VEGETARIAN}', '{MILK}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (25, 'Гуляш с макаронами', 'Говядина, макароны', 185.00, '{}', '{GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (26, 'Овощное рагу', 'Сезонные овощи', 150.00, '{VEGAN}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (27, 'Компот', 'Сухофрукты', 50.00, '{VEGAN}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (28, 'Салат "Витаминный"', 'Капуста, морковь', 85.00, '{VEGAN}', '{}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (29, 'Перловка с грибами', 'Гарнир', 145.00, '{VEGAN}', '{GLUTEN}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (30, 'Шницель куриный', 'Панировка', 190.00, '{}', '{GLUTEN,EGGS}', true);
INSERT INTO public.menu_items (id, name, description, price, diet_flags, allergen_flags, is_active) VALUES (31, 'Картофельное пюре', 'На молоке', 90.00, '{VEGETARIAN}', '{MILK}', true);


--
-- Data for Name: menu_day_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (1, 1, 2);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (2, 1, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (3, 1, 4);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (4, 1, 5);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (5, 1, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (6, 2, 7);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (7, 2, 8);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (8, 2, 9);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (9, 2, 10);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (10, 2, 11);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (11, 3, 12);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (12, 3, 14);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (13, 3, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (14, 3, 15);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (15, 3, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (16, 4, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (17, 4, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (18, 4, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (19, 4, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (20, 4, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (21, 5, 13);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (22, 5, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (23, 5, 14);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (24, 5, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (25, 5, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (26, 6, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (27, 6, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (28, 6, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (29, 6, 26);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (30, 6, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (31, 7, 12);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (32, 7, 15);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (33, 7, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (34, 7, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (35, 7, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (36, 8, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (37, 8, 25);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (38, 8, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (39, 8, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (40, 8, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (41, 9, 13);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (42, 9, 14);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (43, 9, 15);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (44, 9, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (45, 9, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (46, 10, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (47, 10, 30);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (48, 10, 29);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (49, 10, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (50, 10, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (51, 11, 12);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (52, 11, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (53, 11, 14);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (54, 11, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (55, 11, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (56, 12, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (57, 12, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (58, 12, 24);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (59, 12, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (60, 12, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (61, 13, 13);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (62, 13, 15);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (63, 13, 16);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (64, 13, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (65, 13, 18);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (66, 14, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (67, 14, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (68, 14, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (69, 14, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (70, 14, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (303, 19, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (304, 21, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (305, 23, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (306, 25, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (307, 27, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (308, 29, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (309, 31, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (310, 33, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (311, 35, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (312, 37, 6);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (313, 19, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (314, 21, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (315, 23, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (316, 25, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (317, 27, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (318, 29, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (319, 31, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (320, 33, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (321, 35, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (322, 37, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (323, 19, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (324, 21, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (325, 23, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (326, 25, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (327, 27, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (328, 29, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (329, 31, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (330, 33, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (331, 35, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (332, 37, 3);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (333, 20, 7);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (334, 20, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (335, 20, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (336, 22, 8);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (337, 22, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (338, 22, 7);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (339, 24, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (340, 24, 7);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (341, 24, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (342, 26, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (343, 26, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (344, 26, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (345, 28, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (346, 28, 11);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (347, 28, 24);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (348, 30, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (349, 30, 30);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (350, 30, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (351, 32, 9);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (352, 32, 30);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (353, 32, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (354, 34, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (355, 34, 8);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (356, 34, 31);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (357, 36, 20);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (358, 36, 25);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (359, 36, 30);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (360, 38, 21);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (361, 38, 19);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (362, 38, 27);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (171, 15, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (172, 15, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (173, 15, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (174, 16, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (175, 16, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (176, 16, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (177, 17, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (178, 17, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (179, 17, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (180, 18, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (181, 18, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (182, 18, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (243, 39, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (244, 39, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (245, 39, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (246, 40, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (247, 40, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (248, 40, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (249, 41, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (250, 41, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (251, 41, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (252, 42, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (253, 42, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (254, 42, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (255, 43, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (256, 43, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (257, 43, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (258, 44, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (259, 44, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (260, 44, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (261, 45, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (262, 45, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (263, 45, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (264, 46, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (265, 46, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (266, 46, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (267, 79, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (268, 79, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (269, 79, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (270, 80, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (271, 80, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (272, 80, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (273, 81, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (274, 81, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (275, 81, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (276, 82, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (277, 82, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (278, 82, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (279, 83, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (280, 83, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (281, 83, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (282, 84, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (283, 84, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (284, 84, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (285, 85, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (286, 85, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (287, 85, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (288, 86, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (289, 86, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (290, 86, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (291, 87, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (292, 87, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (293, 87, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (294, 88, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (295, 88, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (296, 88, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (297, 89, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (298, 89, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (299, 89, 28);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (300, 90, 17);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (301, 90, 22);
INSERT INTO public.menu_day_items (id, menu_day_id, menu_item_id) VALUES (302, 90, 28);


--
-- Data for Name: menu_item_ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (1, 2, 3, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (2, 2, 6, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (3, 2, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (4, 2, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (5, 2, 29, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (6, 2, 31, 100.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (7, 3, 4, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (8, 3, 7, 7.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (9, 3, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (10, 3, 31, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (11, 4, 5, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (12, 4, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (13, 4, 30, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (14, 5, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (15, 5, 8, 150.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (16, 5, 9, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (17, 5, 10, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (18, 5, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (19, 5, 29, 15.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (20, 5, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (21, 6, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (22, 6, 11, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (23, 6, 12, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (24, 7, 1, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (25, 7, 2, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (26, 7, 13, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (27, 7, 14, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (28, 7, 15, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (29, 7, 16, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (30, 7, 17, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (31, 7, 18, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (32, 7, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (33, 7, 30, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (34, 7, 31, 350.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (35, 8, 1, 180.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (36, 8, 6, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (37, 8, 7, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (38, 8, 16, 15.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (39, 8, 19, 120.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (40, 8, 20, 15.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (41, 8, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (42, 8, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (43, 9, 21, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (44, 9, 22, 140.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (45, 9, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (46, 9, 30, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (47, 9, 31, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (48, 10, 6, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (49, 10, 7, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (50, 10, 23, 90.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (51, 10, 24, 35.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (52, 10, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (53, 11, 25, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (54, 11, 26, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (55, 11, 27, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (56, 11, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (57, 11, 30, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (58, 1, 1, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (59, 1, 2, 90.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (60, 1, 16, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (61, 1, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (62, 1, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (63, 12, 6, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (64, 12, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (65, 12, 21, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (66, 12, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (67, 12, 29, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (68, 12, 31, 100.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (69, 13, 6, 250.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (70, 13, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (71, 13, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (72, 13, 29, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (73, 13, 31, 50.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (74, 13, 33, 45.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (75, 14, 5, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (76, 14, 6, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (77, 14, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (78, 14, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (79, 15, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (80, 15, 6, 150.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (81, 15, 9, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (82, 15, 10, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (83, 15, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (84, 15, 29, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (85, 15, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (86, 16, 38, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (87, 16, 39, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (88, 17, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (89, 17, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (90, 17, 8, 180.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (91, 17, 10, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (92, 17, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (93, 17, 29, 15.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (94, 17, 33, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (95, 18, 38, 50.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (96, 18, 40, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (97, 18, 41, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (98, 18, 42, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (99, 19, 15, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (100, 19, 16, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (101, 19, 19, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (102, 19, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (103, 19, 31, 350.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (104, 19, 34, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (105, 20, 1, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (106, 20, 6, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (107, 20, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (108, 20, 15, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (109, 20, 16, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (110, 20, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (111, 20, 31, 300.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (112, 20, 35, 160.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (113, 21, 15, 50.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (114, 21, 16, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (115, 21, 19, 100.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (116, 21, 21, 90.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (117, 21, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (118, 21, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (119, 21, 31, 220.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (120, 22, 2, 90.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (121, 22, 4, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (122, 22, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (123, 22, 7, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (124, 22, 16, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (125, 22, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (127, 22, 30, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (128, 22, 31, 200.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (129, 23, 15, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (130, 23, 16, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (131, 23, 20, 15.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (132, 23, 21, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (133, 23, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (134, 23, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (135, 24, 1, 220.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (136, 24, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (137, 24, 6, 70.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (138, 24, 7, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (139, 24, 24, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (140, 24, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (141, 25, 2, 110.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (142, 25, 16, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (143, 25, 17, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (144, 25, 23, 90.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (145, 25, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (147, 25, 30, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (148, 25, 31, 300.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (149, 26, 1, 120.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (150, 26, 14, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (151, 26, 15, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (152, 26, 16, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (153, 26, 26, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (154, 26, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (155, 26, 30, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (156, 26, 31, 150.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (157, 27, 29, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (158, 27, 31, 250.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (159, 27, 43, 30.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (160, 28, 14, 120.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (161, 28, 15, 40.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (162, 28, 28, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (163, 28, 29, 5.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (164, 28, 30, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (165, 28, 40, 50.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (166, 29, 7, 8.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (167, 29, 16, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (168, 29, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (169, 29, 31, 250.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (170, 29, 36, 60.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (171, 29, 37, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (172, 30, 5, 1.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (173, 30, 9, 20.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (174, 30, 19, 140.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (175, 30, 20, 25.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (176, 30, 28, 2.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (177, 30, 30, 12.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (178, 31, 1, 220.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (179, 31, 6, 80.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (180, 31, 7, 10.000);
INSERT INTO public.menu_item_ingredients (id, menu_item_id, ingredient_id, qty_per_portion) VALUES (181, 31, 28, 2.000);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (6, 'student3@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{HALAL}', '{}', '2026-01-26 23:11:08.873042', 'Даниил', 'Попов', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (7, 'student4@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{NO_SUGAR}', '{GLUTEN}', '2026-01-26 23:11:08.873042', 'Екатерина', 'Морозова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (8, 'student5@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{}', '{MILK}', '2026-01-26 23:11:08.873042', 'Артём', 'Волков', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (9, 'student6@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{VEGETARIAN,NO_SUGAR}', '{}', '2026-01-26 23:11:08.873042', 'София', 'Орлова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (10, 'student7@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{}', '{EGGS}', '2026-01-26 23:11:08.873042', 'Михаил', 'Лебедев', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (11, 'student8@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{HALAL}', '{SOY}', '2026-01-26 23:11:08.873042', 'Алина', 'Новикова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (12, 'student9@school.local', '$2b$12$VrOSuNFaLcxFIyTJQ0fEkeGxH.8NIGpnOOHtao/H49mf9STg0kHJO', '{VEGAN}', '{PEANUTS}', '2026-01-26 23:11:08.873042', 'Кирилл', 'Фёдоров', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (4, 'ivan.pupkin@school.local', '$2b$12$wAaY3zH/Nb91OjvjMRrp8e4VTe7bNZE/nCZ3wh2S9e21YDL9x29Y2', '{VEGAN,NO_SUGAR}', '{MILK}', '2026-01-26 23:11:08.873042', 'Иван', 'Пупкин', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (2, 'cook1@school.local', '$2b$12$zHucIqRzuYJLlquR0lXiwu/uss5x2xXSgPLtDBsCH4Of4BrZtk/O2', '{}', '{}', '2026-01-26 23:11:08.873042', 'Ирина', 'Петрова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (3, 'cook2@school.local', '$2b$12$YHNF3BUixP97dXv3Fju7f.W2w95Lvs906G6ztzs9YQfTRUq8bgZFW', '{}', '{}', '2026-01-26 23:11:08.873042', 'Наталья', 'Иванова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (1, 'admin@school.local', '$2b$12$8FOu2ZDl55ZsyRta9MXAjurlGMjAut53/hax.qXlyIXC.AJDWVM02
', '{}', '{}', '2026-01-26 23:11:08.873042', 'Алексей', 'Смирнов', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (5, 'student2@school.local', '$2b$12$JY/BvXLeKLxfywgA/y4zw.tkNLuykURvvhWbDZhEbv.0o4tNTEFcO', '{VEGAN}', '{MILK,EGGS,NUTS}', '2026-01-26 23:11:08.873042', 'Мария', 'Соколова', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (14, 'student10@school.local', '$2b$12$AgJDEISypcX7chGWYeGVBuAW5rx2yG09gQw/f0QYxS2sQZIHsIuHK', '{}', '{}', '2026-02-09 13:31:49.197971', 'Петр', 'Гришин', 0.00);
INSERT INTO public.users (id, email, password_hash, diet_flags, allergen_flags, created_at, first_name, last_name, balance) VALUES (15, 'student11@school.local', '$2b$12$kiGZUI8ghB3XRu.1bn.pEunqovjPGGc11mhRoDGHGrg9VloI14FC.', '{}', '{MILK,EGGS,NUTS}', '2026-02-09 13:39:23.092508', 'Семен', 'Грабовский', 0.00);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (526, 5, 333, 'PAID', '2026-02-08 18:43:17.190456', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (527, 5, 334, 'PAID', '2026-02-08 18:43:17.190457', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (525, 5, 303, 'PAID', '2026-02-08 18:43:17.190452', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (528, 5, 304, 'PAID', '2026-02-08 19:48:45.274956', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (529, 5, 337, 'PAID', '2026-02-08 19:48:45.274964', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (530, 5, 338, 'PAID', '2026-02-08 19:48:45.274965', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (531, 4, 303, 'PAID', '2026-02-08 22:20:44.188787', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (532, 4, 334, 'PAID', '2026-02-08 22:52:49.227483', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (534, 6, 335, 'CREATED', '2026-02-09 00:31:36.113403', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (536, 7, 335, 'CREATED', '2026-02-08 23:29:54.483382', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (538, 8, 334, 'PAID', '2026-02-09 00:07:40.35903', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (539, 9, 323, 'PAID', '2026-02-08 22:37:05.62352', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (540, 9, 335, 'CREATED', '2026-02-08 22:37:52.571937', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (542, 10, 335, 'CREATED', '2026-02-08 23:03:34.815448', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (543, 11, 303, 'CREATED', '2026-02-08 23:17:15.511263', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (544, 11, 335, 'CREATED', '2026-02-08 23:23:34.863358', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (533, 6, 303, 'PAID', '2026-02-08 22:05:29.962252', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (541, 10, 323, 'ISSUED', '2026-02-09 00:25:25.504385', '2026-02-09 07:13:15.175368');
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (535, 7, 323, 'ISSUED', '2026-02-09 00:02:55.700646', '2026-02-09 07:13:16.462737');
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (537, 8, 303, 'ISSUED', '2026-02-08 22:44:14.279948', '2026-02-09 07:13:18.245142');
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (388, 4, 245, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (389, 5, 245, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (390, 6, 243, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (391, 8, 244, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (392, 9, 244, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (393, 10, 243, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (394, 12, 244, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (395, 4, 247, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (396, 5, 247, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (397, 6, 247, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (398, 7, 248, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (399, 9, 248, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (400, 12, 247, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (401, 4, 251, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (402, 5, 251, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (403, 6, 249, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (404, 7, 251, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (405, 9, 250, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (406, 10, 249, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (407, 11, 249, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (408, 12, 251, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (409, 4, 253, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (410, 5, 252, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (411, 7, 253, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (412, 8, 253, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (413, 11, 254, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (414, 12, 254, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (415, 4, 257, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (416, 5, 256, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (417, 6, 257, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (418, 7, 257, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (419, 8, 255, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (420, 9, 255, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (421, 10, 256, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (422, 12, 256, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (423, 4, 260, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (424, 5, 258, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (425, 6, 259, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (426, 7, 260, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (427, 8, 258, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (428, 10, 260, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (429, 11, 260, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (430, 4, 261, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (431, 6, 262, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (432, 7, 263, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (433, 8, 261, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (434, 9, 263, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (435, 12, 261, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (436, 4, 266, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (437, 6, 264, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (438, 7, 265, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (439, 8, 265, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (440, 9, 265, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (441, 10, 266, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (442, 12, 266, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (443, 4, 268, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (444, 5, 267, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (445, 6, 269, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (446, 9, 269, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (447, 10, 267, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (448, 11, 267, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (449, 12, 268, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (450, 4, 271, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (451, 5, 270, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (452, 6, 271, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (453, 7, 271, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (454, 9, 271, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (455, 10, 270, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (456, 11, 271, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (457, 12, 271, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (458, 5, 274, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (459, 7, 273, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (460, 8, 275, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (461, 9, 275, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (462, 10, 273, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (463, 11, 274, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (464, 4, 277, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (465, 5, 278, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (466, 6, 277, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (467, 7, 278, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (468, 9, 278, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (469, 10, 276, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (470, 12, 276, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (471, 5, 280, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (472, 6, 281, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (473, 7, 280, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (474, 10, 280, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (475, 11, 280, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (476, 12, 279, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (477, 4, 284, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (478, 5, 284, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (479, 7, 283, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (480, 8, 283, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (481, 10, 282, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (482, 4, 286, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (483, 5, 286, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (484, 6, 285, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (485, 7, 285, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (486, 8, 287, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (487, 9, 287, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (488, 12, 286, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (489, 4, 288, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (490, 5, 288, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (491, 6, 290, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (492, 7, 290, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (493, 9, 290, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (494, 10, 289, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (495, 12, 289, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (496, 4, 291, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (497, 5, 291, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (498, 6, 293, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (499, 9, 293, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (500, 10, 292, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (501, 11, 291, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (502, 12, 292, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (503, 4, 295, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (504, 6, 296, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (505, 8, 294, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (506, 10, 294, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (507, 11, 296, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (508, 12, 296, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (509, 4, 299, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (510, 5, 298, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (511, 6, 297, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (512, 7, 298, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (513, 8, 298, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (514, 9, 297, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (515, 10, 299, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (516, 11, 297, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (517, 4, 302, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (518, 5, 301, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (519, 6, 302, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (520, 7, 302, 'PAID', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (521, 8, 301, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (522, 9, 301, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (523, 10, 301, 'CREATED', '2026-02-04 22:14:19.446334', NULL);
INSERT INTO public.orders (id, user_id, menu_day_item_id, status, created_at, issued_at) VALUES (524, 11, 300, 'PAID', '2026-02-04 22:14:19.446334', NULL);


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (354, 526, 140.00, 'ORDER_EXTERNAL', '2026-02-08 18:43:30.413314', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (355, 525, 70.00, 'ORDER_EXTERNAL', '2026-02-08 18:43:30.413317', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (356, 527, 50.00, 'ORDER_EXTERNAL', '2026-02-08 18:43:30.413318', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (368, 530, 140.00, 'ORDER_EXTERNAL', '2026-02-09 06:51:14.117838', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (369, 529, 50.00, 'ORDER_EXTERNAL', '2026-02-09 06:51:14.117848', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (370, 528, 70.00, 'ORDER_EXTERNAL', '2026-02-09 06:51:14.117849', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (360, 541, 85.00, 'ORDER_EXTERNAL', '2026-02-08 22:52:46.279723', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (361, 537, 70.00, 'ORDER_EXTERNAL', '2026-02-08 22:09:44.655312', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (362, 533, 70.00, 'ORDER_EXTERNAL', '2026-02-09 00:06:58.309727', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (363, 532, 50.00, 'ORDER_EXTERNAL', '2026-02-09 00:40:46.872798', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (364, 535, 85.00, 'ORDER_EXTERNAL', '2026-02-08 22:17:06.54165', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (365, 531, 70.00, 'ORDER_EXTERNAL', '2026-02-09 00:08:21.985594', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (366, 539, 85.00, 'ORDER_EXTERNAL', '2026-02-09 00:12:25.414736', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (367, 538, 50.00, 'ORDER_EXTERNAL', '2026-02-09 00:31:28.745591', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (265, 388, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (266, 391, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (267, 392, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (268, 393, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (269, 394, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (270, 395, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (271, 397, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (272, 398, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (273, 399, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (274, 400, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (275, 401, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (276, 402, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (277, 403, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (278, 404, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (279, 406, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (280, 407, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (281, 411, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (282, 412, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (283, 413, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (284, 414, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (285, 415, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (286, 419, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (287, 420, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (288, 421, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (289, 422, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (290, 423, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (291, 425, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (292, 427, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (293, 428, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (294, 429, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (295, 430, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (296, 432, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (297, 435, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (298, 436, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (299, 437, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (300, 439, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (301, 445, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (302, 446, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (303, 447, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (304, 451, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (305, 452, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (306, 453, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (307, 455, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (308, 457, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (309, 460, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (310, 461, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (311, 462, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (312, 465, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (313, 466, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (314, 467, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (315, 468, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (316, 469, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (317, 471, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (318, 474, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (319, 475, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (320, 476, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (321, 477, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (322, 480, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 8);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (323, 481, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (324, 482, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (325, 484, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (326, 485, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (327, 487, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (328, 488, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (329, 489, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (330, 492, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (331, 493, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (332, 495, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (333, 496, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (334, 498, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (335, 499, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (336, 500, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (337, 501, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (338, 502, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (339, 503, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (340, 504, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (341, 506, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 10);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (342, 507, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (343, 508, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 12);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (344, 510, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (345, 511, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (346, 512, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (347, 514, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 9);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (348, 516, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (349, 517, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 4);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (350, 518, 180.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 5);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (351, 519, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 6);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (352, 520, 85.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 7);
INSERT INTO public.payments (id, order_id, amount, payment_type, created_at, user_id) VALUES (353, 524, 120.00, 'ORDER_EXTERNAL', '2026-02-04 22:14:19.446334', 11);


--
-- Data for Name: purchase_requests; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.purchase_requests (id, created_at, status, created_by_user_id, comment) VALUES (8, '2026-02-08 20:06:56.6179', 'APPROVED', 2, 'Сформировал(а): Петрова Ирина. Период: 5 учебных дней от 2026-02-08');
INSERT INTO public.purchase_requests (id, created_at, status, created_by_user_id, comment) VALUES (10, '2026-02-09 07:33:56.146133', 'APPROVED', 2, 'Сформировал(а): Петрова Ирина. Период: 5 учебных дней от 2026-02-09.');
INSERT INTO public.purchase_requests (id, created_at, status, created_by_user_id, comment) VALUES (9, '2026-02-08 22:47:29.916379', 'APPROVED', 2, 'Сформировал(а): Петрова Ирина. Период: 5 учебных дней от 2026-02-09.');


--
-- Data for Name: purchase_request_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (76, 8, 11, 1600.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (77, 8, 12, 600.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (78, 8, 13, 1000.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (79, 8, 18, 100.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (80, 8, 31, 15000.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (81, 8, 43, 1500.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (82, 9, 42, 2000.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (83, 10, 27, 200.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (84, 10, 36, 2000.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (85, 10, 41, 2000.000);
INSERT INTO public.purchase_request_items (id, purchase_request_id, ingredient_id, qty) VALUES (86, 10, 42, 2000.000);


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.reviews (id, user_id, menu_item_id, rating, comment, created_at) VALUES (1, 5, 3, 2, 'так себе', '2026-01-27 17:18:05.536227');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roles (id, name) VALUES (1, 'admin');
INSERT INTO public.roles (id, name) VALUES (2, 'cook');
INSERT INTO public.roles (id, name) VALUES (3, 'student');


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.subscriptions (id, user_id, start_date, end_date, is_active) VALUES (1, 5, '2026-01-28', '2026-02-05', true);


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_roles (user_id, role_id) VALUES (1, 1);
INSERT INTO public.user_roles (user_id, role_id) VALUES (2, 2);
INSERT INTO public.user_roles (user_id, role_id) VALUES (3, 2);
INSERT INTO public.user_roles (user_id, role_id) VALUES (4, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (5, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (6, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (7, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (8, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (9, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (10, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (11, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (12, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (14, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (15, 3);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 43, true);


--
-- Name: inventory_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_items_id_seq', 1, false);


--
-- Name: menu_day_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_day_items_id_seq', 362, true);


--
-- Name: menu_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_days_id_seq', 114, true);


--
-- Name: menu_item_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_item_ingredients_id_seq', 181, true);


--
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 11, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 544, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_id_seq', 370, true);


--
-- Name: purchase_request_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.purchase_request_items_id_seq', 86, true);


--
-- Name: purchase_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.purchase_requests_id_seq', 10, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- PostgreSQL database dump complete
--

