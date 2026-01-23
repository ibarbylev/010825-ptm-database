/*MySQL ENUM — это специальный тип данных, который хранит одно значение из предопределенного списка строковых значений. Используется для хранения ограниченного набора возможных значений, что делает его удобным для статусов, категорий и других фиксированных вариантов.
Синтаксис:*/

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('active', 'inactive', 'banned') NOT NULL
);

/* Особенности ENUM:
    Хранение и производительность
        MySQL хранит ENUM как числовое значение (индекс в списке).
        ENUM('small', 'medium', 'large') хранится как 1, 2, 3 соответственно.
    Поиск быстрее, чем с VARCHAR, так как сравниваются числа, а не строки.
    Добавление новых значений требует ALTER TABLE, что может быть неудобно.
*/

/* Сравнение значений
        ENUM можно сравнивать как строки: */
SELECT * FROM users WHERE status = 'active';

/*      Или как числа (по индексу): */

SELECT * FROM users WHERE status = 1;  -- 'active'

/* Значение по умолчанию */

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('pending', 'shipped', 'delivered') DEFAULT 'pending'
);


/* Когда использовать?

✅ Если значения фиксированы и изменяются редко (например, status, type).
❌ Если значения могут часто изменяться — лучше использовать отдельную таблицу и FOREIGN KEY.

Если значения могут часто изменяться, лучше использовать таблицу справочник:
 */

CREATE TABLE statuses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_id INT NOT NULL,
    FOREIGN KEY (status_id) REFERENCES statuses(id)
);

-- Это позволит легко добавлять и изменять статусы без ALTER TABLE.