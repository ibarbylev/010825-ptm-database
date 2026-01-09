# Операторы $limit, $skip, и $slice

Эти операторы используются для управления выборкой данных, но применяются в разных контекстах

Для иллюстрации используем ту же коллекцию products:

```
db.products.insertMany([
    { name: "Laptop", tags: ["electronics", "computer", "portable"] },
    { name: "Smartphone", tags: ["electronics", "mobile", "portable"] },
    { name: "Desk", tags: ["furniture", "wood", "office"] },
    { name: "Chair", tags: ["furniture", "wood"] }
]);
```

## 1. `$limit` - Ограничивает количество документов, возвращаемых запросом.

*Пример: Вывести только два первые документа из коллекции.*

```
db.products.find().limit(2);
```

Ожидаемый результат:

```
[
  { "_id": ObjectId("..."), "name": "Laptop", "tags": ["electronics", "computer", "portable"] },
  { "_id": ObjectId("..."), "name": "Smartphone", "tags": ["electronics", "mobile", "portable"] }
]
```

## 2. `$skip` - пропускает указанное количество документов перед началом возврата.


*Пример: пропустить первые два документа и вывести оставшиеся*
```
db.products.find().skip(2);
```
Ожидаемый результат:
```
[
  { "_id": ObjectId("..."), "name": "Desk", "tags": ["furniture", "wood", "office"] },
  { "_id": ObjectId("..."), "name": "Chair", "tags": ["furniture", "wood"] }
]
```


## 3. `$slice` - "Вырезает" из указанной позиции массива указанное число элементов

Применяется для форматирования вывода массивов (т.е. ТОЛЬКО в project!) внутри документа

*Пример: получить только первые два тега для каждого документа*
```
db.products.find(
  {}, { name: 1, tags: { $slice: 2 } }
);
```

Ожидаемый результат:
```
[
  { "_id": ObjectId("..."), "name": "Laptop", "tags": ["electronics", "computer"] },
  { "_id": ObjectId("..."), "name": "Smartphone", "tags": ["electronics", "mobile"] },
  { "_id": ObjectId("..."), "name": "Desk", "tags": ["furniture", "wood"] },
  { "_id": ObjectId("..."), "name": "Chair", "tags": ["furniture", "wood"] }
]
```

*Пример: получить только последние два тега для каждого документа*
```
db.products.find(
  {}, { name: 1, tags: { $slice: -2 } }
);
```

```
[
  { "_id": ObjectId("..."), "name": "Laptop", "tags": ["computer", "portable"] },
  { "_id": ObjectId("..."), "name": "Smartphone", "tags": ["mobile", "portable"] }
  { "_id": ObjectId("..."), "name": "Desk", "tags": ["wood", "office"] },
  { "_id": ObjectId("..."), "name": "Chair", "tags": ["furniture", "wood"] }
]
```
*Пример: получить 1 элемент, начиная со 2-го индекса для каждого документа*
```
db.products.find(
  {}, { name: 1, tags: { $slice: [2, 1] } }
);

[
  { "_id": ObjectId("..."), "name": "Laptop", "tags": ["portable"] },
  { "_id": ObjectId("..."), "name": "Smartphone", "tags": ["portable"] },
  { "_id": ObjectId("..."), "name": "Desk", "tags": ["office"] },
  { "_id": ObjectId("..."), "name": "Chair","tags": [] }
]
```

*Пример: В массиве `tags` оставить только 1 последний элемент и сохранить под именем `singe_tag`:
**ВНИМАНИЕ** - в решении использован другой синтаксис (`$slice` и `имя_массива` поменялись  местами:  

`{ новое_имя: { $slice ["$имя_массива", число_элементов] } }`

```
db.products.find(
  {}, { name: 1, new_tag: { $slice: ["$tags", -1] } }
);

[
  { "_id": ObjectId("..."), "name": "Laptop", "new_tag": ["portable"] },
  { "_id": ObjectId("..."), "name": "Smartphone", "new_tag": ["portable"] },
  { "_id": ObjectId("..."),  "name": "Desk", "new_tag": ["office"] },
  { "_id": ObjectId("..."), "name": "Chair", "new_tag": ["wood"] }
]
```  

| Оператор   | Применение                                                            | Контекст          | Пример результата                         |
|------------|------------------------------------------------------------------------|-------------------|-------------------------------------------|
| **`$limit`** | Ограничивает количество возвращаемых документов.                      | Для всей выборки. | Только первые N документов.              |
| **`$skip`**  | Пропускает определённое количество документов перед началом возврата. | Для всей выборки. | Документы после пропуска первых N.        |
| **`$slice`** | Ограничивает количество элементов внутри массива в каждом документе. | Для массивов.     | Только первые/последние элементы массива. |

ВЫВОД:
`$limit` и `$skip` - применяются для управления количеством документов в запросе.
`$slice` - для работы с массивами внутри документов.

