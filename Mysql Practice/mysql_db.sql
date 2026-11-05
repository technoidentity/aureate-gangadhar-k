/*markdown
# MySQL Online Store Notebook

This notebook creates the onlinestore schema and lets you run SQL queries with output shown directly below each cell.
*/

CREATE DATABASE IF NOT EXISTS onlinestore;
USE onlinestore;

DROP TABLE IF EXISTS product;
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    manufacturer TEXT NOT NULL
);

INSERT INTO product (
    product_id,
    name,
    description,
    price,
    manufacturer
)
VALUES
    (1, 'Atomic Nose Hair Trimmer', 'Trim your nose hairs with the precision of an atomic clock!', 19.99, 'Mad Inventors Inc.'),
    (2, 'Selfie Toaster', 'Get your face on your toast every morning with our selfie toaster!', 24.99, 'Goofy Gadgets Corp.'),
    (3, 'Cat-Poop Coffee', 'The only coffee made from the finest cat poop beans!', 29.99, 'Absurd Accessories'),
    (4, 'Inflatable Briefcase', 'Need more storage space? Inflate our briefcase to double its size!', 39.99, 'Wacky Wares Ltd.'),
    (5, 'Unicorn Horn Polish', 'Keep your unicorn''s horn shiny and smooth with our magical polish!', 9.99, 'Silly Supplies Co.'),
    (6, 'The Mind Probe', 'A device from Star Wars that can extract information directly from a person''s mind.', 19.99, 'Mad Inventors Inc.'),
    (7, 'Lightsabers', 'Elegant and deadly energy swords wielded by Jedi and Sith alike.', 25, 'Mad Inventors Inc.'),
    (8, 'The Sonic Screwdriver', 'A versatile tool capable of performing a wide variety of tasks, from unlocking doors to repairing electronics.', 15.1, 'Absurd Accessories'),
    (9, 'The Infinite Improbability Generator', 'A device that can create impossible and absurd events, such as a spaceship suddenly turning into a giant sperm whale.', 9.99, 'Silly Supplies Co.'),
    (10, 'The Neuralyzer', 'A flashy device that erases people''s memories of specific events or encounters.', 33.55, 'Silly Supplies Co.');

USE onlinestore;
SELECT * FROM product ORDER BY product_id;

USE onlinestore;
SELECT product_id, name, price
FROM product
ORDER BY price DESC;

USE onlinestore;
SELECT COUNT(*) AS total_products FROM product;

USE onlinestore;
SELECT name, manufacturer, price
FROM product
WHERE price > 20
ORDER BY price DESC;