/* Оконные функции (или window functions) — это специальные функции в SQL,
которые позволяют выполнять вычисления по строкам
в пределах определённого набора строк (окна),
но без группировки этих строк в одну запись.
Это значит, что вы можете видеть как сами строки,
так и результаты вычислений по этим строкам одновременно.

Иными словами, оконные функции позволяют вам сделать что-то вроде "группировки",
но при этом сохранить все строки в результате.
Обычная группировка с GROUP BY объединяет строки в одну запись,
а оконные функции — нет. */

-- пример данных без группировки
SELECT
    first_name, department_id, salary
FROM
    hr.employees;

-- пример с обычной группировкой
SELECT
    department_id, AVG(salary)
FROM
    hr.employees
GROUP BY department_id;

-- а что, если мы хотим одновременно показать имя, департамент, ЗП и ср.ЗП по департаменту?

SELECT
	e1.first_name,
    e1.department_id,
    e1.salary,
    e2.avg_salary_by_department
FROM
    hr.employees AS e1
		JOIN
	(SELECT
		department_id, AVG(salary) AS avg_salary_by_department
	FROM
		hr.employees
	GROUP BY department_id) AS e2 ON e1.department_id = e2.department_id
;

-- пример с использованием оконной функции OVER(), которая позволяет
-- находить среднее значение "над"(помимо) текущими данными таблицы

SELECT department_id, last_name, salary,
       AVG(salary) OVER() AS avg_salary
FROM hr.employees;


-- однако, здесь мы видим не совсем то, что нужно - среднюю ЗП по фирме в целом
-- кстати, как этот же результат можно получить без использования оконной функции?
SELECT
    department_id, last_name, salary,
    (SELECT AVG(salary) FROM hr.employees) AS avg_salary
FROM
    hr.employees;


-- нужный результат (ср ЗП по каждому деп.) можно получить с помощью PARTITION BY
SELECT department_id, last_name, salary,
       AVG(salary) OVER(PARTITION BY department_id) AS avg_salary_by_department
FROM hr.employees;



/* Основные особенности оконных функций:

    Окно (window) — это набор строк, по которым будет выполняться функция.
    Задаётся с помощью OVER(),
    где в качестве аргумента может быть указана,
    например, опция PARTITION BY (подобно GROUP BY).

    Оконные функции могут использоваться с такими функциями, как:
        AVG() — среднее значение
        SUM() — сумма
        ROW_NUMBER() — порядковый номер строки
        RANK() — ранжирование строк
        и другие.

    Не уменьшают количество строк. Все строки исходной таблицы остаются на месте,
    а результат оконной функции добавляется как новый столбец. */