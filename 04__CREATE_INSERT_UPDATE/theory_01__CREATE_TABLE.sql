/* 
Синтаксис формирования таблицы

CREATE TABLE <table_name> (
	<column1_name> <data_type>,
	<column2_name> <data_type>,
	<column3_name> <data_type>,
	...
    <columnN_name> <data_type>
);
 */

CREATE DATABASE IF NOT EXISTS 170225_dam_ClassWork;

USE 170225_dam_ClassWork;

CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    HireDate DATE DEFAULT (CURRENT_DATE),
    Salary DECIMAL(9, 2) CHECK (Salary > 0),
    Email VARCHAR(100) UNIQUE,
    Position ENUM('manager', 'developer', 'designer') DEFAULT 'manager'
);

/*
INSERT INTO TableName (Column1, Column2, Column3, ...)
VALUES (Value1, Value2, Value3, ...);
*/

INSERT INTO Employees (FirstName, LastName, BirthDate,  Salary, Email)
VALUES
	('John', 'Smith', '2000-02-03', 5000, 'john.smith@asdasd.com'),
	('Jane', 'Smith', '2002-02-03', 5000, 'jane.smith@asdasd.com');

SELECT * FROM Employees;


/* Создать копию таблицы (сохранить результат выборки как таблицу) */
CREATE TABLE Employees_2 AS
SELECT * FROM Employees;