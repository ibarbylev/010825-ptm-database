/*  Представление (view) - это виртуальная таблица, 
созданная на основе одной или нескольких таблиц в базе данных. 
Оно предоставляет удобный способ доступа к данным, а также может 
использоваться для упрощения выполнения сложных запросов. 

Представление сохраняет определенный запрос как объект в базе данных, 
к которому можно обратиться, как если бы это была обычная таблица.


CREATE VIEW v_table AS
	SELECT
		<column1_name>,
		<column2_name>, 
		<column3_name>
	FROM 
		<table_name>
	WHERE
		<condition1> AND <condition2>;
*/

USE training_db;

CREATE VIEW v_table AS
    SELECT 
        *
    FROM
        toys1
    WHERE
        toy_name = 'Велосипед' OR weight > 0;
        
/* Проверям результат */         
SELECT * FROM v_table;

/* Меняем данные исзодной таблицы */         
UPDATE toys1 
SET 
    weight = 15
WHERE
    toy_name = 'Скутер' LIMIT 1;
    
/* Проверям результат изменений в исходной таблицы и затем во view*/        
SELECT * FROM toys1;
