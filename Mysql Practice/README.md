# MySQL practice

This notebook builds on the Online Store examples from *Grokking Relational
Database Design* by Qiang Hao and Michael Tsikerdekis. It keeps the original
ten products and adds SQL exercises using the practice tables already in
this project. The original MIT license is preserved in [../LICENSE](../LICENSE).

## Files and execution order

1. `mysql_db.sql` creates `onlinestore.product` and fills missing sample IDs.
2. `mysql_notebook.sql` reads that table and creates or reuses the separate
   `onlinestore_practice` examples.

The original product has `product_id`, `name`, `description`, `price` and a
text `manufacturer` column. It has no `manufacturer_id`. The separate
`practice_product` table uses a manufacturer foreign key for normalized
joins. The review example uses `practice_review`; it does not modify an
existing `onlinestore.review` with a different schema.

Git stores these SQL files, not your running database or editor connection.
Run the setup once on a new server. If your original product table is
already loaded, you can go directly to the notebook.

## Requirements and obtaining MySQL

Use MySQL **8.4**, or a compatible **8.0.16+** release. MySQL 8.0.16 is needed
for enforced CHECK constraints; the LATERAL example needs 8.0.14+. These are
MySQL scripts, not SQLite or MariaDB scripts.

Install [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
and its command-line client for your operating system, or obtain the
[official Docker image](https://hub.docker.com/_/mysql):

```bash
docker pull mysql:8.4
```

For a new local Docker server, run the following in Bash. Choose a password
at the prompt; it is passed through the environment rather than saved in
the repository. Port 3306 must be free.

```bash
read -rs -p 'Choose a MySQL root password: ' MYSQL_ROOT_PASSWORD
printf '\n'
export MYSQL_ROOT_PASSWORD
docker run --name mysql-practice \
  --publish 127.0.0.1:3306:3306 \
  --env MYSQL_ROOT_PASSWORD \
  --detach mysql:8.4
unset MYSQL_ROOT_PASSWORD
```

This image initializes its own data directory on first startup. Keep that
container if you want to keep its database. Allow initialization to finish
before connecting; inspect `docker logs mysql-practice` if startup fails.

## Start and check the server

Startup depends on your installation; a server is not started by opening
an SQL file. Use the service name documented by your installer. For
example, some Linux installations use `sudo systemctl start mysql`.
That command does not apply to Docker or to every operating system.

For your existing Docker server:

```bash
docker start onlinestore-mysql
docker exec onlinestore-mysql mysql --version
docker exec -it onlinestore-mysql mysql -u root -p
```

For the new container above, substitute `mysql-practice` for
`onlinestore-mysql`. The remaining Docker examples assume your existing
`onlinestore-mysql` container.

With a locally installed client:

```bash
mysql --version
mysql -h 127.0.0.1 -P 3306 -u root -p
```

`mysql --version` reports the client version. At the MySQL prompt, check the
server with `SELECT VERSION();`. Use your own username instead of root
when a database owner account is available.

## Run from this repository's root

With a local MySQL client, run the setup and then the notebook:

```bash
mysql -h 127.0.0.1 -P 3306 -u root -p < "Mysql Practice/mysql_db.sql"
mysql -h 127.0.0.1 -P 3306 -u root -p < "Mysql Practice/mysql_notebook.sql"
```

For a local socket connection, the shorter equivalents are:

```bash
mysql -u root -p < "Mysql Practice/mysql_db.sql"
mysql -u root -p < "Mysql Practice/mysql_notebook.sql"
```

With Docker, copy the files into the container and open the MySQL client:

```bash
docker cp "Mysql Practice/mysql_db.sql" onlinestore-mysql:/tmp/mysql_db.sql
docker cp "Mysql Practice/mysql_notebook.sql" onlinestore-mysql:/tmp/mysql_notebook.sql
docker exec -it onlinestore-mysql mysql -u root -p
```

Then run these at the MySQL prompt:

```sql
SOURCE /tmp/mysql_db.sql;
SOURCE /tmp/mysql_notebook.sql;
```

Check the result:

```sql
SELECT VERSION();
SHOW TABLES FROM onlinestore;
SELECT COUNT(*) AS products FROM onlinestore.product;
DESCRIBE onlinestore.product;
SHOW TABLES FROM onlinestore_practice;
SELECT * FROM onlinestore_practice.practice_account ORDER BY account_id;
```

The supplied dataset has ten products. On an unmodified practice dataset,
account 1 finishes with 900.00 and account 2 with 800.00 on every full run.
The setup preserves existing product rows and any additional IDs rather
than replacing them. `INSERT IGNORE` adds missing sample IDs; it does not
repair an incompatible existing schema or overwrite local edits.

## Running individual statements and notebook cells

In the MySQL client, enter one statement ending in `;`, then press Enter.
Run prerequisite CREATE and INSERT statements before dependent queries.
The notebook's `USE` statements deliberately change schemas; execute the
appropriate one when resuming midway.

In VS Code, use **Open With → SQL Notebook** for `mysql_notebook.sql`.
Select a MySQL connection for your actual server. Your existing local
connection is `Learning`, host `127.0.0.1`, port `3306`, database
`onlinestore`. Enter passwords in the connection form, not in Git.

Use the command-line client for a complete reproducible run. SQL Notebook
uses blank lines as cell boundaries and borrows connections from a pool.
Do not rely on the same session across cells. Keep each transaction and
all four statements of an index guard in one cell, enable multiple
statements, and select the right database for that session. The longer
legacy sections can be executed as whole cells with multiple statements.

The optional routine and trigger examples are below in this README. Copy
one SQL block to the MySQL client after running the notebook. DELIMITER is
a client command, not server SQL; restore DELIMITER ; as shown. Do not send
DELIMITER through a notebook cell or an API driver. The examples recreate
only their named practice routines and trigger, then clean up afterwards.

## What the examples cover

- Database inspection, projection, aliases, DISTINCT, filtering, ordering
  and pagination using the original products.
- Aggregates, grouping, HAVING and practical price comparisons.
- DML and DDL on disposable tables, including ADD, MODIFY, DROP COLUMN,
  TRUNCATE and DROP TABLE.
- Integer, exact and approximate numeric, string, date/time and boolean
  types; keys, candidate keys, defaults, checks and referential integrity.
- Many-to-many relationships, all requested join forms, subqueries,
  correlated queries, EXISTS, ANY and ALL.
- Single and multiple CTEs, recursion, ranking, LAG, LEAD and window totals
  and averages.
- UNION and UNION ALL, intersection and difference equivalents, selection,
  projection and Cartesian products. FULL OUTER JOIN is emulated because
  MySQL has no FULL OUTER JOIN operator. The EXISTS/NOT EXISTS examples also
  work on MySQL releases before native INTERSECT/EXCEPT support.
- 1NF, 2NF, 3NF and BCNF, functional dependencies and concrete insertion,
  update and deletion anomalies with rollback.
- B-tree, unique, composite and FULLTEXT indexes, EXPLAIN and index costs.
- ACID, transaction rollback, savepoints, commit and repeatable balances.
- Views; optional procedures, functions, triggers and permissions examples.
- Date/string functions and order totals, missing relationships, duplicate
  values, second-highest prices and top products per manufacturer.

## Repeat runs and permissions

The notebook does not drop or update `onlinestore.product`. It reuses the
normalized practice tables with `CREATE TABLE IF NOT EXISTS` and safe sample
inserts. It drops/recreates only its explicitly disposable tables; do not
store personal data in those tables. The account example resets the two
sample balances. DDL implicitly commits, so keep it outside transactions.

The default script needs a user who can create/use both named schemas and
manage its practice tables, indexes and views. It does not issue GRANT,
REVOKE or change global server settings. `SHOW GRANTS` inspects only the
current user's grants. Destructive practice examples stay in
`onlinestore_practice`.

Optional routines need CREATE ROUTINE, ALTER ROUTINE and EXECUTE privileges.
The trigger example needs TRIGGER. With binary logging enabled, function
or trigger creation can require additional DBA permission; ask your DBA
rather than changing server settings from the notebook. DCL examples below require a DBA-provisioned account. Use an authorized learning
server rather than a production database.

The index guards query `information_schema.statistics` and prepare a
CREATE statement only when the named index is absent. MySQL 8.4 does **not**
support `CREATE INDEX IF NOT EXISTS`.

## Troubleshooting

| Error or unexpected output | What to check |
| --- | --- |
| `mysql: command not found` | Install the client or use `docker exec ... mysql`. |
| Connection refused | Start the correct server/container; check host and port. |
| No active connection | Activate the connection in the SQL Notebook sidebar, not a different extension. |
| Access denied | Check username, host grants and password. |
| Unknown database/table | Run the setup and preceding notebook sections; check SELECT DATABASE(). |
| Unknown manufacturer_id on product | The original product has text manufacturer. ID joins use practice_product. |
| Unknown column in an existing practice table | Inspect SHOW CREATE TABLE. IF NOT EXISTS does not migrate old schemas; use a fresh learning database if its schema differs. |
| Duplicate key/table/index while running a fragment | Start at that section's reset/setup; do not rerun only a non-idempotent statement. |
| CREATE INDEX IF NOT EXISTS syntax error | Use the supplied metadata guards; that syntax is unsupported. |
| DELIMITER syntax error | Run the optional SQL block from this README through the mysql client. |
| Function/trigger permission error | Use an authorized DBA account or skip the optional example. |
| Empty duplicate-email result | Expected: the unique email index prevents duplicate emails. |
| Tiny tables do not use an index | Expected: a table scan may be cheaper. Indexes cost storage and writes. |

## Validation references

The SQL syntax follows the official [MySQL 8.4 manual](https://dev.mysql.com/doc/refman/8.4/en/),
including [indexes](https://dev.mysql.com/doc/refman/8.4/en/create-index.html),
[stored programs and delimiters](https://dev.mysql.com/doc/refman/8.4/en/stored-programs-defining.html),
and [binary-logging restrictions](https://dev.mysql.com/doc/refman/8.4/en/stored-programs-logging.html).

## Checks performed for this revision

The setup and default notebook were executed twice on fresh, isolated
MySQL 8.4.13 and 8.0.46 servers. Optional procedures, the function and the
trigger were executed twice on both versions. The checks confirmed the
original ten product rows stayed unchanged, the final account balances
were 900.00/800.00, and invalid foreign keys, duplicate keys, NULL values
and CHECK violations were rejected. A schema-scoped learner account also
ran the complete default script without global DBA privileges.

Before comment cleanup, all 136 saved notebook cells were also run twice using the installed SQL
Notebook MySQL driver against MySQL 8.4.13. These checks used disposable
containers; they did not run destructive examples on your existing server.

## Optional procedures and function

Run this block in the MySQL client with the routine privileges described above.

```sql
USE onlinestore_practice;
DROP PROCEDURE IF EXISTS practice_products_above;
DROP FUNCTION IF EXISTS practice_price_with_tax;
DELIMITER $$
CREATE PROCEDURE practice_products_above(IN minimum_price DECIMAL(10,2))
SQL SECURITY INVOKER
READS SQL DATA
BEGIN
    SELECT product_name, price FROM practice_product
    WHERE price >= minimum_price ORDER BY price DESC, product_id;
END$$
CREATE FUNCTION practice_price_with_tax(amount DECIMAL(10,2), rate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL
SQL SECURITY INVOKER
BEGIN
    RETURN ROUND(amount * (1 + rate / 100), 2);
END$$
DELIMITER ;
CALL practice_products_above(40.00);
SELECT product_name, practice_price_with_tax(price, 18.00) AS taxed_price FROM practice_product;
DROP PROCEDURE practice_products_above;
DROP FUNCTION practice_price_with_tax;
```

## Optional trigger

This trims the customer name before the new order-rule row is stored.
Run it in the MySQL client with TRIGGER and any required binary-log privileges.

```sql
USE onlinestore_practice;
DROP TRIGGER IF EXISTS practice_trim_customer;
DELETE FROM v21_order_rule WHERE id IN (901, 902);
DELIMITER $$
CREATE TRIGGER practice_trim_customer
BEFORE INSERT ON v21_order_rule
FOR EACH ROW
BEGIN
    SET NEW.customer = TRIM(NEW.customer);
END$$
DELIMITER ;
INSERT INTO v21_order_rule (id, customer, quantity) VALUES
(901, '  Asha  ', 2), (902, '  Ravi  ', 1);
SELECT id, CONCAT('[', customer, ']') AS stored_customer, quantity, status
FROM v21_order_rule WHERE id IN (901, 902);
DROP TRIGGER practice_trim_customer;
DELETE FROM v21_order_rule WHERE id IN (901, 902);
```

## Optional permissions

A DBA must provision the practice_reader account first. These examples grant
then revoke read access to one table; use the actual account host.

```sql
GRANT SELECT ON onlinestore_practice.practice_product TO 'practice_reader'@'localhost';
SHOW GRANTS FOR 'practice_reader'@'localhost';
REVOKE SELECT ON onlinestore_practice.practice_product FROM 'practice_reader'@'localhost';
```
