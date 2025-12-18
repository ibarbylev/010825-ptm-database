from pprint import pprint
from pymongo import MongoClient  # pip install pymongo

from local_settings import MONGODB_URL_READ

with MongoClient(MONGODB_URL_READ) as client:
    TIMES = 5  # число документов на печать по умолчанию
    task_statement = []  # список условий задач
    data = []  # список документов по каждому решению задачи

    """ ********************** Блок задач **************************** """

    # === Задача 1 (пример решения) ===
    task_statement.append(
        'Задача 1: Найти документы всех 40-летних'
    )

    # ----- в result подставляем решение из mongodb -----
    result = client['ich']['US_Adult_Income'].aggregate([
        {
            '$match': {
                'age': 40
            }
        }
    ])

    data.append(result)

    # ===== Задача 2 =====
    task_statement.append(
        'Условие задачи 2'
    )

    # ----- в result подставляем решение из mongodb -----
    result = ''

    data.append(result)

    """ *************** Блок вывод всех результатов на печать *************** """

    # Цикл по задачам
    for task_num, result in enumerate(data):
        print(50 * '=')
        print(task_statement[task_num])
        print()

        # Цикл по выводу документов решения
        docs = list(result)
        for idx, doc in enumerate(docs[:TIMES]):
            # print(idx, 50 * '-')
            pprint(doc)

        print(f"Total: {len(docs)} docs")

