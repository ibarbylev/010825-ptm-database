/* Внутри конструкции OVER() в SQL могут быть несколько компонентов,
которые определяют, как будет работать оконная функция. Возможные элементы включают:

    PARTITION BY — Разделение на группы (или окна).
    ORDER BY — Определение порядка строк внутри окна.
    ROWS или RANGE — Определение диапазона строк относительно текущей строки в окне
		(например, для функций скользящего среднего или кумулятивных сумм).

Вот возможные варианты использования этих элементов:
1. Пустое OVER()

	Если OVER() не содержит никаких параметров, функция применяется ко всем строкам сразу:*/

SELECT first_name, last_name, salary,
	SUM(salary) OVER () AS total_salary
FROM hr.employees;

/*
2. PARTITION BY

Разделяет строки на группы (разделы), и функция будет применяться отдельно к каждой группе:*/

SELECT
	first_name, last_name, salary, department_id,
	SUM(salary) OVER (PARTITION BY department_id) AS dept_total_salary
FROM hr.employees;

/*
3. ORDER BY

	Задает порядок строк внутри окна, и в зависимости от функции результаты
	будут вычисляться с учетом этого порядка:*/

SELECT
	first_name, last_name, salary, department_id,
	RANK() OVER (ORDER BY salary DESC) AS rank_
FROM hr.employees;

/*
4. PARTITION BY + ORDER BY

	Объединение PARTITION BY и ORDER BY используется для того, чтобы применить функцию
    к разделам данных и одновременно задать порядок внутри каждого раздела:*/

SELECT
	first_name, last_name, salary, department_id,
	RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM hr.employees;

/*
5. ROWS или RANGE

	Эти элементы используются для ограничения диапазона строк внутри окна
    относительно текущей строки. Например, вы можете задать диапазон
    для скользящих вычислений или кумулятивных сумм.

ROWS работает с конкретными строками, относительно текущей строки:*/

SELECT
	first_name, last_name, salary, department_id,
	SUM(salary) OVER (ORDER BY salary ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_sum
FROM hr.employees;

/*Здесь скользящая сумма считается для текущей строки, одной строки до нее и одной строки после.

RANGE работает с диапазоном значений:*/

SELECT
	first_name, last_name, salary, department_id,
	SUM(salary) OVER (ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum
FROM employees;

/*Здесь кумулятивная сумма подсчитывается от первой строки до текущей строки,
основываясь на значениях, а не на количестве строк.


Полный список элементов, которые могут быть внутри OVER():

    PARTITION BY — разделение на группы.
    ORDER BY — порядок строк.
    ROWS — диапазон строк относительно текущей строки.
    RANGE — диапазон значений относительно текущей строки.
    GROUPS (в некоторых диалектах SQL) — другой способ ограничения диапазона для работы с группами строк.

Примеры сложных комбинаций:

    С PARTITION BY, ORDER BY, и диапазоном ROWS:*/

SELECT
	first_name, last_name, salary, department_id,
	SUM(salary) OVER (PARTITION BY department ORDER BY salary ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS sliding_sum
FROM hr.employees;

/*Здесь сумма зарплат считается для текущей строки и двух предыдущих строк,
но внутри каждого департамента.

С PARTITION BY, ORDER BY, и диапазоном RANGE:*/

SELECT
	first_name, last_name, salary, department_id,
	SUM(salary) OVER (PARTITION BY department_id ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_salary
FROM hr.employees;

/*Здесь кумулятивная сумма рассчитывается для каждой строки в пределах департамента,
начиная с первой строки до текущей строки, по значениям зарплат.


Важные моменты:

    PARTITION BY разделяет данные, а ORDER BY задает порядок.
    ROWS и RANGE уточняют диапазон строк или значений для более тонкого управления окнами.*/

