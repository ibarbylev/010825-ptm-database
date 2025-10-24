#  pip install mysql-connector-python

import mysql.connector
from _local_settings import dbconfig

#
# dbconfig = {
#     'host': HOST,
#     'user': USER,
#     'password': PASSWORD,
#     'database': DATABASE,
# }

connection = mysql.connector.connect(**dbconfig)

cursor = connection.cursor()


# Получение списка таблиц
cursor.execute("SHOW TABLES;")
tables = cursor.fetchall()

# Вывод списка таблиц
print("Список таблиц в базе данных:")
for table in tables:
    print(table[0])


cursor.close()
connection.close()

