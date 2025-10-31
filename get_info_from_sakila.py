#  pip install mysql-connector-python

import mysql.connector
from _local_settings_ich1 import dbconfig

dbconfig['database'] = 'sakila'


with mysql.connector.connect(**dbconfig) as connection:
    with connection.cursor() as cursor:

        # Получение списка таблиц
        cursor.execute("SHOW TABLES;")
        tables = cursor.fetchall()

        # Вывод списка таблиц
        print("Список таблиц в базе данных:")
        for table in tables:
            print(table[0])

        # Передаём запрос в БД
        query = "SELECT * FROM film LIMIT %s;"
        cursor.execute(query, (10,))

        # Получаем имена столбцов
        column_names = [desc[0] for desc in cursor.description]
        print(*column_names, sep=" | ")

        # Вывод 10 строк таблицы film
        rows = cursor.fetchall()
        for row in rows:
            print(row)