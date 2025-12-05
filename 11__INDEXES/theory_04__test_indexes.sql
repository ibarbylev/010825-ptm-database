/* Используем БД testdb с таблицей big_table
   на 10_000_0000 записей.
   Индекс idx_big_table_age уже должен быть создан.

   По умолчанию mysqlx_connect_timeout = 30 секунд.
   По факту создание индекса занимает около 40 секунд.
   Увеличиваем timeout соединения, настройкой в
   SQL Editor: DBMS connection read timeout interval до 60 секунд


 */


USE testdb;
-- CREATE INDEX idx_big_table_age ON big_table(age);
SELECT age FROM big_table WHERE age = 30;
EXPLAIN SELECT age FROM big_table WHERE age = 30;
SELECT * FROM big_table WHERE age = 30;
EXPLAIN SELECT * FROM big_table WHERE age = 30;

DROP INDEX idx_big_table_age on big_table;

SELECT age FROM big_table WHERE age = 30;
EXPLAIN SELECT age FROM big_table WHERE age = 30;
SELECT * FROM big_table WHERE age = 30;
EXPLAIN SELECT * FROM big_table WHERE age = 30;



