MERGE dbo.ingredients AS T
USING (VALUES
(N'Classic Sesame Bun','buns',1.50,N'Fresh sesame seed bun','/images/buns/sesame-bun.jpg',1,1),
(N'Whole Wheat Bun','buns',1.75,N'Healthy whole wheat bun','/images/buns/whole-wheat-bun.jpg',1,2),
(N'Brioche Bun','buns',2.00,N'Rich and buttery brioche bun','/images/buns/brioche-bun.jpg',1,3),
(N'Gluten-Free Bun','buns',2.25,N'Gluten-free alternative bun','/images/buns/gluten-free-bun.jpg',1,4),

(N'Beef Patty','patties',4.50,N'Juicy 100% beef patty','/images/patties/beef-patty.jpg',1,1),
(N'Chicken Breast','patties',4.25,N'Grilled chicken breast','/images/patties/chicken-breast.jpg',1,2),
(N'Turkey Patty','patties',4.00,N'Lean turkey patty','/images/patties/turkey-patty.jpg',1,3),
(N'Veggie Patty','patties',3.75,N'Plant-based veggie patty','/images/patties/veggie-patty.jpg',1,4),
(N'Salmon Patty','patties',5.50,N'Fresh salmon patty','/images/patties/salmon-patty.jpg',1,5),

(N'Lettuce','toppings',0.50,N'Fresh crisp lettuce','/images/toppings/lettuce.jpg',1,1),
(N'Tomato','toppings',0.75,N'Fresh tomato slices','/images/toppings/tomato.jpg',1,2),
(N'Onion','toppings',0.50,N'Raw or grilled onions','/images/toppings/onion.jpg',1,3),
(N'Pickles','toppings',0.50,N'Dill pickle slices','/images/toppings/pickles.jpg',1,4),
(N'Mushrooms','toppings',1.00,N'Sautéed mushrooms','/images/toppings/mushrooms.jpg',1,5),
(N'Bacon','toppings',1.50,N'Crispy bacon strips','/images/toppings/bacon.jpg',1,6),
(N'Avocado','toppings',1.25,N'Fresh avocado slices','/images/toppings/avocado.jpg',1,7),
(N'Jalapeños','toppings',0.75,N'Spicy jalapeño peppers','/images/toppings/jalapenos.jpg',1,8),

(N'Ketchup','sauces',0.25,N'Classic tomato ketchup','/images/sauces/ketchup.jpg',1,1),
(N'Mustard','sauces',0.25,N'Yellow mustard','/images/sauces/mustard.jpg',1,2),
(N'Mayo','sauces',0.25,N'Creamy mayonnaise','/images/sauces/mayo.jpg',1,3),
(N'BBQ Sauce','sauces',0.50,N'Smoky BBQ sauce','/images/sauces/bbq-sauce.jpg',1,4), 
(N'Ranch','sauces',0.50,N'Creamy ranch dressing','/images/sauces/ranch.jpg',1,5),
(N'Sriracha','sauces',0.50,N'Spicy sriracha sauce','/images/sauces/sriracha.jpg',1,6),
(N'Aioli','sauces',0.75,N'Garlic aioli','/images/sauces/aioli.jpg',1,7),
(N'Buffalo Sauce','sauces',0.50,N'Spicy buffalo sauce','/images/sauces/buffalo-sauce.jpg',1,8)
) AS S(name,category,price,description,image_url,is_available,sort_order)
ON  T.name = S.name
WHEN MATCHED THEN
  UPDATE SET
    category     = S.category,
    price        = S.price,
    description  = S.description,
    image_url    = S.image_url,
    is_available = S.is_available,
    sort_order   = S.sort_order
WHEN NOT MATCHED THEN
  INSERT (name,category,price,description,image_url,is_available,sort_order)
  VALUES (S.name,S.category,S.price,S.description,S.image_url,S.is_available,S.sort_order);
GO

SELECT category, COUNT(*) AS cnt
FROM dbo.ingredients
GROUP BY category
ORDER BY category;
GO
