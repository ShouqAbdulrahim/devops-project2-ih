INSERT INTO ingredients (name, category, price, descrip$
VALUES ('Cheddar Cheese', 'toppings', 1.20, 'Delicious $
GO

SELECT id, name, category, price, sort_order
FROM ingredients
WHERE name = 'Cheddar Cheese';
GO









