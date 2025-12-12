// 1. Подключиться к ich_edit.movies, используя учётную запись с правами на запись (если не удалось подключится к Atlas!)

/* 2. Желательно работать в Atlas с коллекцией sample_mflix.movies (там у всех есть свои коллекции и нет ограничений!). */

/* 3. Выбрать фильмы и сериалы,  у которых рейтинг imdb.rating составляет 8 и выше, отсортировать их по убыванию рейтинга IMDb, и 50 документов записать в новую коллекцию под названием highly_rated_movies.

* Не забыть добавить свое имя для уникальности коллекции, если работаем с ich_edit.movies, при работе с atlas можно оставить highly_rated_movies */

/* 4. Создать новую коллекцию и загрузить в нее информацию из файла:
https://github.com/it-career-hub/MySQL_databases/blob/main/BankChurners.csv */

/* 5. Исключите при импорте 4 последних столбца :
"Total_Ct_Chng_Q4_Q1","Avg_Utilization_Ratio","Naive_Bayes_Classifier_Attrition_Flag_Card_Category_Contacts_Count_12_mon_Dependent_count_Education_Level_Months_Inactive_12_mon_1","Naive_Bayes_Classifier_Attrition_Flag_Card_Category_Contacts_Count_12_mon_Dependent_count_Education_Level_Months_Inactive_12_mon_2" */

/* 6. Создать индекс для текстового поиска в MongoDB на основе поля Education_Level из коллекции credit_cards. */

// 7. В mongosh создать текстовый индекс на поле Education_Level.

// 8. Осуществить поиск документов, содержащих указанный текст в поле Education_Level (выбрать все документы, где уровень образования "Graduate")

// 9. Проверить, используется ли текстовый индекс в вашем запросе.

/* 10. Создать составной индекс для полей Education_Level и Customer_Age в коллекции credit_cards (поэкспериментировать с запросами, чтобы проверить, работают ли индексы "winningPlan"):
    - Написать запрос с использованием метода .find
    - Написать запрос с использованием метода .sort */

// 11. Реализовать то же самое в compass.

/* 12. Создать составной индекс для полей Income_Category и Total_Trans_Amt:
    - Написать запрос с использованием операции $find
    - Написать запрос с использованием операции $sort */


