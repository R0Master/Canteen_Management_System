BEGIN;

-- =========================
-- Breakfast (примерные 5)
-- =========================

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Овсяная каша', 'На молоке', 90.00, '{VEGETARIAN}'::diet_flag[], '{MILK}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Овсяная каша');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Гречневая каша', 'Сливочное масло', 85.00, '{VEGETARIAN}'::diet_flag[], '{MILK}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Гречневая каша');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Яичница', '2 яйца', 95.00, '{}'::diet_flag[], '{EGGS}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Яичница');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Сырники', 'Со сметаной', 110.00, '{VEGETARIAN}'::diet_flag[], '{MILK,EGGS,GLUTEN}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Сырники');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Тосты с джемом', 'Пшеничный хлеб', 70.00, '{VEGETARIAN}'::diet_flag[], '{GLUTEN}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Тосты с джемом');


-- =========================
-- Lunch (примерные 5)
-- =========================

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Борщ', 'Классический', 140.00, '{}'::diet_flag[], '{}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Борщ');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Куриная котлета с пюре', 'Пюре на молоке', 170.00, '{}'::diet_flag[], '{MILK}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Куриная котлета с пюре');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Рыба с рисом', 'Запечённая', 175.00, '{}'::diet_flag[], '{FISH}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Рыба с рисом');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Макароны с сыром', 'Сыр твёрдый', 150.00, '{VEGETARIAN}'::diet_flag[], '{GLUTEN,MILK}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Макароны с сыром');

INSERT INTO menu_items (name, description, price, diet_flags, allergen_flags, is_active)
SELECT 'Овощной салат', 'Свежие овощи', 90.00, '{VEGAN}'::diet_flag[], '{}'::allergen_flag[], TRUE
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Овощной салат');

COMMIT;

-- Проверка:
-- SELECT id, name, price, diet_flags, allergen_flags, is_active FROM menu_items ORDER BY id;
