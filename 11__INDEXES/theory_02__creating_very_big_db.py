"""Программа создание большой таблицы
для тестирования эффективности индексов
"""

# pip install mysql-connector-python
import mysql.connector
import random

# pip install faker - удобный пакет для генерации тестовых значений
from faker import Faker
from time import time

# ============== Убрать нижнее подчёркивание в _local_settings.py!!! ====================
# ------------------- и добавить пароль (и хост с логином) ------------------------------
from local_settings import dbconfig


# Параметры
TABLE_NAME = 'big_table'
NUM_ROWS = 10_000_000  # можно увеличить
BATCH_SIZE = 10_000    # пакетная вставка для производительности

# Инициализация
fake = Faker()

# Подключение к БД
with mysql.connector.connect(**dbconfig) as conn:
    with conn.cursor() as cursor:

        # Создаём ДБ, если её ещё нет
        cursor.execute("CREATE DATABASE IF NOT EXISTS testdb;")
        cursor.execute("USE testdb;")

        # Удалим таблицу, если уже есть
        cursor.execute(f"DROP TABLE IF EXISTS {TABLE_NAME}")

        # Создание таблицы
        cursor.execute(f"""
            CREATE TABLE {TABLE_NAME} (
                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255),
                email VARCHAR(255),
                age INT,
                created_at DATETIME
            )
        """)

        # Вставка данных пакетами
        def insert_batch():
            for i in range(0, NUM_ROWS, BATCH_SIZE):
                values = []
                for _ in range(BATCH_SIZE):
                    name = fake.name()
                    email = fake.email()
                    age = random.randint(18, 90)
                    created_at = fake.date_time_between(start_date='-5y', end_date='now')
                    values.append((name, email, age, created_at))
                cursor.executemany(
                    f"INSERT INTO {TABLE_NAME} (name, email, age, created_at) VALUES (%s, %s, %s, %s)",
                    values
                )
                print(f"[{i + BATCH_SIZE:,}/{NUM_ROWS:,}] записей вставлено")

        # Подсчёт времени создания таблицы
        start = time()
        insert_batch()
        print(f"✅ Данные вставлены за {time() - start:.2f} сек.")

