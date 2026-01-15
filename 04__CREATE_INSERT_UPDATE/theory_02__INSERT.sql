/*
Синтаксис формирования таблицы

insert into <table_name>(
	<column1_name>,
	<column2_name>, 
	<column3_name>
)values(
		<value1>,
		<value2>,
		<value3>
);

 */


USE 170225_dam_ClassWork;

SELECT * FROM goods;

INSERT INTO goods 
	(title, quantity, in_stock, arrival_date) 
VALUES 
	("Велосипед", 10, "Y", "2024-08-22");

INSERT INTO goods 
VALUES
	("Самокат",	3, 	"N", "2024-08-25"),
	("Роликовые коньки", 2, "Y", "2024-08-25");
    
    
INSERT INTO goods 
VALUES
	("Самокат",	3, 	"N", "2024-08-25"),
	("Роликовые коньки", 2, "Y", "2024-08-25");
    