USE onlinestore;

SELECT *
FROM product
ORDER BY product_id;

SELECT product_id, name, price
FROM product
ORDER BY price DESC;

SELECT COUNT(*) AS total_products
FROM product;

SELECT name, manufacturer, price
FROM product
WHERE price > 20
ORDER BY price DESC;

SELECT product_id, name, price
FROM product
WHERE manufacturer = 'Mad Inventors Inc.'
ORDER BY price DESC;

SELECT * FROM product;

SELECT product_id, name, price
FROM product



SELECT * FROM product;

SELECT name FROM product;

SELECT name, price FROM product;

SELECT * FROM product WHERE product_id = 2;

SELECT name, price FROM product WHERE price > 20;

SELECT p.name, m.name AS manufacturer
FROM product p
JOIN manufacturer m
ON p.manufacturer_id = m.manufacturer_id;

SELECT name, manufacturer, price
FROM product
ORDER BY price DESC;

SELECT name, price FROM product
ORDER BY price DESC;

SELECT ROUND(AVG(price), 2) AS average_price
FROM product;


SELECT name, manufacturer, price
FROM product
ORDER BY price DESC;

CREATE TABLE v03_demo (
    id INT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    price NUMERIC(8,2)
);


INSERT INTO v03_demo (id, name, price)
VALUES (1, 'Pocket Rocket', 12.50);


SELECT * FROM v03_demo;

UPDATE v03_demo
SET price = 13.75
WHERE id = 1;


ALTER TABLE v03_demo
ADD COLUMN description TEXT;

DELETE FROM v03_demo
WHERE id = 1;

DROP TABLE v03_demo;

CREATE TABLE v04_review_tag (
    tag_id INT PRIMARY KEY,
    review_id INT NOT NULL REFERENCES review(review_id),
    tag VARCHAR(30) NOT NULL
);

INSERT INTO v04_review_tag
VALUES (1, 1, 'useful'), (2, 2, 'funny');


SELECT p.name, r.review_text
FROM product p
INNER JOIN review r
ON p.product_id = r.product_id;


CREATE TABLE v10_key_demo (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    display_name VARCHAR(50)
);


INSERT INTO v10_key_demo VALUES
(1, 'a@example.com', 'Asha'),
(2, 'b@example.com', 'Bala');


SELECT * FROM v10_key_demo
WHERE user_id = 1;

SELECT * FROM v10_key_demo
WHERE email = 'b@example.com';

SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'grokking_practice'
AND table_name = 'v10_key_demo'
ORDER BY constraint_name;

SELECT email, COUNT(*) AS occurrences
FROM v10_key_demo
GROUP BY email
HAVING COUNT(*) > 1;


DROP TABLE v10_key_demo;

CREATE TABLE v11_text_demo (
    id INT PRIMARY KEY,
    product_code CHAR(6),
    username VARCHAR(20),
    comments TEXT
);

INSERT INTO v11_text_demo VALUES
(1, 'P00001', 'ravi', 'Simple and useful product'),
(2, 'P00002', 'anu', 'A longer description of this interesting item');


SELECT * FROM v11_text_demo ORDER BY id;

SELECT username, LENGTH(username) AS characters
FROM v11_text_demo;


SELECT username FROM v11_text_demo
WHERE username LIKE 'r%';

DROP TABLE v11_text_demo;

CREATE TABLE v12_number_demo (
    id INT PRIMARY KEY,
    approx DOUBLE PRECISION,
    exact_value NUMERIC(10,2)
);

INSERT INTO v12_number_demo VALUES
(1, 0.1, 0.10),
(2, 0.2, 0.20),
(3, 0.3, 0.30);

SELECT SUM(approx) AS approximate_total
FROM v12_number_demo;

SELECT SUM(exact_value) AS exact_total
FROM v12_number_demo;

DROP TABLE v12_number_demo;

CREATE DATABASE IF NOT EXISTS onlinestore_practice;

USE onlinestore_practice;

SELECT DATABASE();

CREATE TABLE IF NOT EXISTS author (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS book (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS author_book (
    author_id INT,
    book_id INT,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO author VALUES
(1, 'Ravi'),
(2, 'Asha'),
(3, 'Meera');

INSERT INTO book VALUES
(101, 'Database Basics'),
(102, 'Space Stories'),
(103, 'Rust Adventures');

INSERT INTO author_book VALUES
(1, 101),
(1, 102),
(2, 102),
(3, 103);

SHOW TABLES;

SELECT a.name AS author_name, b.title AS book_title
FROM author_book ab
JOIN author a ON a.author_id = ab.author_id
JOIN book b ON b.book_id = ab.book_id;

SELECT a.name, b.title FROM author_book ab JOIN author a ON a.author_id=ab.author_id JOIN book b ON b.book_id=ab.book_id;


SELECT a.name, COUNT(ab.book_id) AS book_count FROM author a LEFT JOIN author_book ab ON ab.author_id=a.author_id GROUP BY a.author_id,a.name;

SELECT b.title, COUNT(ab.author_id) AS author_count FROM book b LEFT JOIN author_book ab ON ab.book_id=b.book_id GROUP BY b.book_id,b.title;

SELECT a.name FROM author a LEFT JOIN author_book ab ON ab.author_id=a.author_id WHERE ab.book_id IS NULL;

SELECT b.title FROM book b JOIN author_book ab ON ab.book_id=b.book_id GROUP BY b.book_id,b.title HAVING COUNT(*) > 1;

SELECT column_name, ordinal_position FROM information_schema.key_column_usage WHERE table_schema='onlinestore_practice' AND table_name='purchase_item' AND constraint_name='PRIMARY' ORDER BY ordinal_position;

CREATE TABLE v19_phone_raw (student_id INT PRIMARY KEY, phones TEXT NOT NULL);

INSERT INTO v19_phone_raw VALUES (101, '9876,8765');

CREATE TABLE v19_phone (student_id INT NOT NULL, phone VARCHAR(20) NOT NULL, PRIMARY KEY (student_id,phone));

INSERT INTO v19_phone (student_id, phone) VALUES (101, '9876'), (101, '8765');

SELECT * FROM v19_phone_raw;

SELECT * FROM v19_phone ORDER BY student_id,phone;

DROP TABLE v19_phone, v19_phone_raw;

CREATE TABLE v20_enrollment_raw (student_id INT, course_id INT, student_name VARCHAR(60), course_name VARCHAR(60), grade VARCHAR(2), PRIMARY KEY(student_id,course_id));

INSERT INTO v20_enrollment_raw VALUES (1,10,'Ravi','SQL','A'), (1,20,'Ravi','Rust','B'), (2,10,'Anu','SQL','A');

SELECT student_id, student_name FROM v20_enrollment_raw ORDER BY student_id;

SELECT DISTINCT student_id,student_name FROM v20_enrollment_raw ORDER BY student_id;

SELECT DISTINCT course_id,course_name FROM v20_enrollment_raw ORDER BY course_id;

/* ================================================================
   COMPLETE CHAPTER PRACTICE — each statement is a separate query.
   MySQL 8.0+. Run this section after the existing examples above.
   ================================================================ */

/* Database instance and schema: inspect actual tables and their columns. */
SHOW TABLES;
DESCRIBE product;

/* Schema design and constraints: primary, candidate (UNIQUE), foreign,
   composite keys, NOT NULL, DEFAULT, and CHECK. */
CREATE TABLE IF NOT EXISTS practice_manufacturer (
    manufacturer_id INT PRIMARY KEY,
    manufacturer_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS practice_product (
    product_id INT PRIMARY KEY,
    sku VARCHAR(30) NOT NULL UNIQUE,
    product_name VARCHAR(120) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    manufacturer_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    FOREIGN KEY (manufacturer_id) REFERENCES practice_manufacturer(manufacturer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS practice_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS practice_order (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES practice_customer(customer_id)
);

CREATE TABLE IF NOT EXISTS practice_order_item (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES practice_order(order_id),
    FOREIGN KEY (product_id) REFERENCES practice_product(product_id)
);

/* Insert sample records (DML). */
INSERT IGNORE INTO practice_manufacturer VALUES
(1, 'Northwind Devices', 'USA'), (2, 'Maple Tech', 'Canada');

INSERT IGNORE INTO practice_product (product_id, sku, product_name, price, manufacturer_id) VALUES
(1, 'KB-001', 'Keyboard', 45.00, 1), (2, 'MS-001', 'Mouse', 20.00, 1),
(3, 'MN-001', 'Monitor', 220.00, 2);

INSERT IGNORE INTO practice_customer VALUES
(1, 'Asha', 'Delhi'), (2, 'Ravi', 'London'), (3, 'Noor', 'Delhi');

INSERT IGNORE INTO practice_order VALUES
(101, 1, '2026-01-12'), (102, 1, '2026-01-20'), (103, 2, '2026-02-02');

INSERT IGNORE INTO practice_order_item VALUES
(101, 1, 1), (101, 2, 2), (102, 3, 1);

/* SELECT all columns; projection; selection; AND; OR; IN; BETWEEN; LIKE. */
SELECT * FROM practice_product;
SELECT product_name, price FROM practice_product;
SELECT product_name, price FROM practice_product WHERE price > 40;
SELECT product_name FROM practice_product WHERE price > 30 AND manufacturer_id = 1;
SELECT product_name FROM practice_product WHERE manufacturer_id = 1 OR price > 200;
SELECT product_name FROM practice_product WHERE manufacturer_id IN (1, 2);
SELECT product_name, price FROM practice_product WHERE price BETWEEN 20 AND 100;
SELECT product_name FROM practice_product WHERE product_name LIKE '%o%';

/* ORDER BY, LIMIT, DISTINCT. */
SELECT product_name, price FROM practice_product ORDER BY price DESC LIMIT 2;
SELECT DISTINCT city FROM practice_customer;

/* Aggregate functions and grouping, WHERE before grouping, HAVING after. */
SELECT COUNT(*) AS product_count FROM practice_product;
SELECT SUM(price) AS total_price FROM practice_product;
SELECT AVG(price) AS average_price FROM practice_product;
SELECT MIN(price) AS lowest_price, MAX(price) AS highest_price FROM practice_product;
SELECT manufacturer_id, COUNT(*) AS products FROM practice_product GROUP BY manufacturer_id;
SELECT manufacturer_id, COUNT(*) AS products FROM practice_product WHERE price > 30 GROUP BY manufacturer_id;
SELECT manufacturer_id, COUNT(*) AS products FROM practice_product GROUP BY manufacturer_id HAVING COUNT(*) > 1;

/* MySQL does not implement GROUPING SETS: UNION ALL gives the two groupings. */
SELECT manufacturer_id, NULL AS status, COUNT(*) AS product_count FROM practice_product GROUP BY manufacturer_id
UNION ALL
SELECT NULL, status, COUNT(*) FROM practice_product GROUP BY status;

/* INNER, LEFT, RIGHT, FULL OUTER equivalent, and CROSS joins. */
SELECT p.product_name, m.manufacturer_name FROM practice_product p
INNER JOIN practice_manufacturer m ON m.manufacturer_id = p.manufacturer_id;
SELECT c.customer_name, o.order_id FROM practice_customer c
LEFT JOIN practice_order o ON o.customer_id = c.customer_id;
SELECT m.manufacturer_name, p.product_name FROM practice_product p
RIGHT JOIN practice_manufacturer m ON m.manufacturer_id = p.manufacturer_id;
SELECT m.manufacturer_name, p.product_name FROM practice_manufacturer m
LEFT JOIN practice_product p ON p.manufacturer_id = m.manufacturer_id
UNION ALL
SELECT m.manufacturer_name, p.product_name FROM practice_manufacturer m
RIGHT JOIN practice_product p ON p.manufacturer_id = m.manufacturer_id
WHERE m.manufacturer_id IS NULL;
SELECT c.customer_name, m.manufacturer_name FROM practice_customer c CROSS JOIN practice_manufacturer m;

/* Subquery comparisons: scalar, IN, EXISTS, ANY, ALL. */
SELECT product_name, price FROM practice_product
WHERE price > (SELECT AVG(price) FROM practice_product);
SELECT product_name FROM practice_product WHERE manufacturer_id IN
(SELECT manufacturer_id FROM practice_manufacturer WHERE country = 'USA');
SELECT c.customer_name FROM practice_customer c WHERE EXISTS
(SELECT 1 FROM practice_order o WHERE o.customer_id = c.customer_id);
SELECT product_name, price FROM practice_product WHERE price > ANY
(SELECT price FROM practice_product WHERE manufacturer_id = 1);
SELECT product_name, price FROM practice_product WHERE price >= ALL
(SELECT price FROM practice_product WHERE manufacturer_id = 1);

/* CTE, recursive CTE, and window functions. */
WITH costly AS (SELECT product_name, price FROM practice_product WHERE price > 30)
SELECT * FROM costly ORDER BY price DESC;
WITH RECURSIVE number_list (n) AS
(SELECT 1 UNION ALL SELECT n + 1 FROM number_list WHERE n < 5)
SELECT n FROM number_list;
SELECT product_name, price,
       ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,
       RANK() OVER (ORDER BY price DESC) AS price_rank,
       DENSE_RANK() OVER (ORDER BY price DESC) AS dense_price_rank,
       SUM(price) OVER (ORDER BY product_id ROWS UNBOUNDED PRECEDING) AS running_total
FROM practice_product;

/* LATERAL: top priced product per manufacturer (MySQL 8.0.14+). */
SELECT m.manufacturer_name, top_item.product_name, top_item.price
FROM practice_manufacturer m
JOIN LATERAL (
    SELECT p.product_name, p.price FROM practice_product p
    WHERE p.manufacturer_id = m.manufacturer_id ORDER BY p.price DESC LIMIT 1
) AS top_item ON TRUE;

/* Relational algebra: selection and projection; union; intersection/difference equivalents. */
SELECT product_name, price FROM practice_product WHERE price > 40;
SELECT city AS location FROM practice_customer UNION SELECT country FROM practice_manufacturer;
SELECT city FROM practice_customer WHERE city IN (SELECT country FROM practice_manufacturer);
SELECT city FROM practice_customer WHERE city NOT IN (SELECT country FROM practice_manufacturer);
SELECT c.customer_name, m.manufacturer_name FROM practice_customer c CROSS JOIN practice_manufacturer m;
/* Join is demonstrated above; SQL may preserve duplicates unless DISTINCT is requested. */

/* Normalization and functional dependencies (see accompanying comments):
   1NF: atomic phone values; 2NF: order_item quantity depends on both key columns;
   3NF: department details belong in department, not repeated in employee;
   BCNF: every determinant must be a superkey. */
CREATE TABLE IF NOT EXISTS practice_phone_1nf (
    customer_id INT NOT NULL, phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (customer_id, phone)
);
INSERT IGNORE INTO practice_phone_1nf VALUES (1, '5550101'), (1, '5550102');
SELECT customer_id, phone FROM practice_phone_1nf;
/* Update anomaly: repeating manufacturer details would require multiple row updates. */
SELECT manufacturer_id, manufacturer_name, country FROM practice_manufacturer;

/* DDL and DML examples on a disposable table. */
CREATE TABLE IF NOT EXISTS practice_ddl_demo (
    id INT PRIMARY KEY, description VARCHAR(80) NOT NULL DEFAULT 'sample',
    amount DECIMAL(8,2) CHECK (amount >= 0)
);
INSERT INTO practice_ddl_demo (id, amount) VALUES (1, 10.00);
UPDATE practice_ddl_demo SET amount = 12.50 WHERE id = 1;
DELETE FROM practice_ddl_demo WHERE id = 1;
ALTER TABLE practice_ddl_demo ADD COLUMN note VARCHAR(40);
TRUNCATE TABLE practice_ddl_demo;
DROP TABLE practice_ddl_demo;

/* Indexes: B-tree for equality/range/order; FULLTEXT for word search. */
CREATE INDEX idx_practice_product_price ON practice_product(price);
CREATE FULLTEXT INDEX idx_practice_product_text ON practice_product(product_name);
SELECT product_name FROM practice_product WHERE price BETWEEN 20 AND 100;
SELECT product_name FROM practice_product WHERE MATCH(product_name) AGAINST ('keyboard' IN NATURAL LANGUAGE MODE);

/* Transaction, savepoint, rollback, commit. This example rolls back to preserve balances. */
CREATE TABLE IF NOT EXISTS practice_account (
    account_id INT PRIMARY KEY, balance DECIMAL(10,2) NOT NULL CHECK (balance >= 0)
);
INSERT IGNORE INTO practice_account VALUES (1, 1000.00), (2, 700.00);
START TRANSACTION;
UPDATE practice_account SET balance = balance - 100 WHERE account_id = 1;
SAVEPOINT after_debit;
UPDATE practice_account SET balance = balance + 100 WHERE account_id = 2;
ROLLBACK TO SAVEPOINT after_debit;
ROLLBACK;
START TRANSACTION;
UPDATE practice_account SET balance = balance - 100 WHERE account_id = 1;
UPDATE practice_account SET balance = balance + 100 WHERE account_id = 2;
COMMIT;
SELECT * FROM practice_account ORDER BY account_id;

/* DCL examples are comments because they require a provisioned account and admin rights.
GRANT SELECT ON onlinestore_practice.practice_product TO 'practice_reader'@'localhost';
REVOKE SELECT ON onlinestore_practice.practice_product FROM 'practice_reader'@'localhost';
*/

/* Problem-solving patterns: no orders, duplicates, date range, calculated totals. */
SELECT c.customer_name FROM practice_customer c WHERE NOT EXISTS
(SELECT 1 FROM practice_order o WHERE o.customer_id = c.customer_id);
SELECT city, COUNT(*) AS same_city_count FROM practice_customer GROUP BY city HAVING COUNT(*) > 1;
SELECT order_id, order_date FROM practice_order WHERE order_date >= '2026-01-01' AND order_date < '2026-02-01';
SELECT o.order_id, SUM(oi.quantity * p.price) AS calculated_total
FROM practice_order o JOIN practice_order_item oi ON oi.order_id = o.order_id
JOIN practice_product p ON p.product_id = oi.product_id GROUP BY o.order_id;

SELECT student_id,course_id,grade FROM v20_enrollment_raw;

DROP TABLE v20_enrollment_raw;

CREATE TABLE v21_employee_raw (employee_id INT PRIMARY KEY, employee_name VARCHAR(60), department_id INT, department_name VARCHAR(60));

INSERT INTO v21_employee_raw VALUES (1,'Ravi',10,'Engineering'), (2,'Anu',10,'Engineering'), (3,'Priya',20,'Support');

SELECT * FROM v21_employee_raw ORDER BY employee_id;

CREATE TABLE v21_department AS SELECT DISTINCT department_id,department_name FROM v21_employee_raw;

CREATE TABLE v21_order_rule (id INT PRIMARY KEY, customer VARCHAR(50) NOT NULL, quantity INT CHECK(quantity>0), status VARCHAR(20) NOT NULL DEFAULT 'new');

SELECT GRANTEE, TABLE_NAME, PRIVILEGE_TYPE
FROM information_schema.TABLE_PRIVILEGES
WHERE TABLE_SCHEMA = 'onlinestore_practice'
ORDER BY TABLE_NAME, PRIVILEGE_TYPE LIMIT 20;



SELECT * FROM product;













