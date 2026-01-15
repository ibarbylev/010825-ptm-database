## Примеры оконных функций MongoDB

### 1. Агрегация (сумма, среднее и т.д.)

Посчитать агрегаты **по группе**, не "схлопывая" документы.

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$userId",
      output: {
        totalAmount: { $sum: "$amount" },
        avgAmount:   { $avg: "$amount" },
        minAmount:   { $min: "$amount" },
        maxAmount:   { $max: "$amount" },
        cnt:         { $count: {} }
      }
    }
  }
])
```

---

### 2. Кумулятивная агрегация (накопительные значения)

**Накопительная сумма**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$userId",
      sortBy: { createdAt: 1 },
      output: {
        runningTotal: {
          $sum: "$amount",
          window: { documents: ["unbounded", "current"] }
        }
      }
    }
  }
])
```

---


**Кумулятивная агрегация по диапазону дат (последние 7 дней)**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$userId",
      sortBy: { createdAt: 1 },
      output: {
        last7DaysSum: {
          $sum: "$amount",
          window: {
            range: [-7, 0],
            unit: "day"
          }
        }
      }
    }
  }
])
```

---

### 4. Функции смещения (LAG / LEAD)

**Предыдущее значение (LAG)**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$userId",
      sortBy: { createdAt: 1 },
      output: {
        prevAmount: {
          $shift: {
            output: "$amount",
            by: -1
          }
        }
      }
    }
  }
])
```

---

**Следующее значение (LEAD)**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$userId",
      sortBy: { createdAt: 1 },
      output: {
        nextAmount: {
          $shift: {
            output: "$amount",
            by: 1
          }
        }
      }
    }
  }
])
```

---

### 4. Ранжирование

**`RANK` (с пропусками)**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$category",
      sortBy: { amount: -1 },
      output: {
        rank: { $rank: {} }
      }
    }
  }
])
```

---

**`DENSE RANK` (без пропусков)**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$category",
      sortBy: { amount: -1 },
      output: {
        denseRank: { $denseRank: {} }
      }
    }
  }
])
```

---

**Порядковый номер строки**

```js
db.sales.aggregate([
  {
    $setWindowFields: {
      partitionBy: "$category",
      sortBy: { amount: -1 },
      output: {
        rowNumber: { $documentNumber: {} }
      }
    }
  }
])
```

---

### Получить 5 последних уникальных документов

Пример документов:

```json
[
    {
        "timestamp": "2025-05-01T15:34:00",
        "search_type": "keyword",
        "params": {
            "keyword": "matrix"
        },
        "results_count": 3
   },
    {
        "timestamp": "2025-05-01T15:35:00",
        "search_type": "genre__years_range",
        "params": {
            "genre": "Action",
            "years_range": "2001-2010"
        },
        "results_count": 5
   }
]
```

```python
def last_5_uniq_queries(collection):
    pipeline = [
        {
            "$setWindowFields": {
                "partitionBy": "$params",
                "sortBy": { "timestamp": -1 },
                "output": { "rank": { "$rank": {} } }
            }
        },
        { "$match": { "rank": 1 } },
        { "$sort": { "timestamp": -1 } },
        { "$limit": 5 },
        { "$project": { "_id": 0, "params": 1, "timestamp": 1, "results_count": 1 } }
    ]

    return list(collection.aggregate(pipeline))
```