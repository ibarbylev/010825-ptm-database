/* В MySQL и некоторых других БД - атрибут AUTO_INCREMENT, 
то есть поле, значение которого увеличивается базой данных автоматически 
при добавлении каждой новой записи в таблицу. */

USE 170225_dam_ClassWork;

CREATE TABLE toys1 (
    toy_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    toy_name VARCHAR(100),
    weight INTEGER
);

SELECT * FROM toys1;

INSERT INTO toys1 
	(toy_name, weight) 
VALUES 
	("Велосипед", 10);


INSERT INTO toys1 
	(toy_name, weight) 
VALUES 
	("Самокат", 10),
    ("Скейтборд", 10);


-- =================================================================================

CREATE TABLE toys2 (
    toy_id INT PRIMARY KEY,
    toy_name VARCHAR(100),
    weight INTEGER
);

SELECT * FROM toys2;

INSERT INTO toys2
	(toy_id, toy_name, weight) 
VALUES 
	(NULL, "Велосипед", 10);










