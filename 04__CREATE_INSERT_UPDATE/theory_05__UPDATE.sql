/*    ИЗМЕНЕНИЕ ДАННЫХ
Для изменения данных таблицы можно использовать команду UPDATE,
которая позволяет изменить данные в какой-либо таблице.

(ВНИМАНИЕ: В Workbench по умолчанию стоит ограничение,
    которое не позволяет изменять данные с помощью
    "неограниченных" запросов (без WHERE и / или LIMIT)
)

UPDATE <table_name>
SET
    <column1_name> = <value1>,
    <column2_name> = <value2>
WHERE
    <condition1>' LIMIT N;
*/

USE 170225_dam_ClassWork;

UPDATE toys1 
SET 
    weight = 15
WHERE
    weight > 0 LIMIT 100;

SELECT * FROM toys1;

UPDATE toys1 
SET 
    weight = 20 LIMIT 100;