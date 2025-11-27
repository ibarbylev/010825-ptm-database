# Операторы для фильтрации документов в массиве

## 1. $all — поиск документов по указанному набору элементов

Оператор `$all` в MongoDB применяется только к массивам. Он используется для проверки,   
содержит ли массив все указанные значения, независимо от порядка элементов в массиве.

Пример:

В коллекции products, значения поля tags является массивом.
```
db.products.insertMany([
    { name: "Laptop", tags: ["electronics", "computer", "portable"] },
    { name: "Smartphone", tags: ["electronics", "mobile", "portable"] },
    { name: "Desk", tags: ["furniture", "wood", "office"] },
    { name: "Chair", tags: ["furniture", "wood"] } 
]);
```
Необходимо найти продукты, у которых в массиве tags одновременно присутствуют "electronics" и "portable".
```
db.products.find({
    tags: { $all: ["electronics", "portable"] }
});
```

Ожидаемый результат:
```
[{
  _id: ObjectId('6746172fc9bca7bc6f2363bc'),
  name: 'Laptop',
  tags: [ 'electronics', 'computer', 'portable' ]
},
{
  _id: ObjectId('6746172fc9bca7bc6f2363bd'),
  name: 'Smartphone',
  tags: [ 'electronics', 'mobile', 'portable' ]
}]
```

## 2. $size — поиск по указанному числу элементов в массиве

Оператор `$size` проверяет количество элементов в массиве.

*Пример: выбрать документы, где массив в tag содержит элемента*
```
db.collection.find({ 
    tags: { $size: 3 } 
});
```

Ожидаемый результат:
```
[{
  _id: ObjectId("67461aa23f054cc437def0fd"),
  name: "Laptop",
  tags: [ "electronics", "computer", "portable" ]
},
{
  _id: ObjectId("67461aa23f054cc437def0fe"),
  name: "Smartphone",
  tags: [ "electronics", "mobile", "portable" ]
},
{
  _id: ObjectId(:67461aa23f054cc437def0ff"),
  name: "Desk",
  tags: [ "furniture", "wood", "office" ]
}]
```

## Как использовать условие (> или <) относительно размера массива?

В этом случае необходимо использовать оператор `$expr` вместе с `$gt` и `$size`.

Например, выражение
```
{
  $expr: { $gt: [ { $size: "$tags" }, 3 ] }
}
```
вернёт все документы, где размер массива `tags` > 3:
- `$expr` позволяет использовать выражения внутри запроса.
- `$size: "$tags"` — получает длину массива.
- `$gt: [..., 3]` — проверяет, больше ли длина 3.


## 3. $in - проверка наличия указанного элемента в массиве

Оператор `$in` проверяет, содержит ли массив хотя бы одно из указанных значений.

*Пример:  Найти товары, у которых в массиве tags есть хотя бы один из тегов "portable" или "mobile"*    

```
db.collection.find({ 
    tags: { $in: ["portable", "mobile"] } 
});
```

Ожидаемый результат:
```
[{
  _id: ObjectId("67461aa23f054cc437def0fd"),
  name: "Laptop",
  tags: [ "electronics", "computer", "portable" ]
},
{
  _id: ObjectId("67461aa23f054cc437def0fe"),
  name: "Smartphone",
  tags: [ "electronics", "mobile", "portable" ]
},
```

## 4. $nin - проверка отсутствия указанного элемента в массиве

Оператор `$nin` проверяет, не содержит ли массив ни одно из указанных значений.

*Пример:  Найти товары, у которых в массиве tags не ни тега "portable" ни тега "wood"*    

```
db.collection.find({ 
    tags: { $nin: ["portable", "wood"] } 
});
```

Ожидаемый результат: (пустое значение)

## 5. Объединение всех строковых элементов массива в одну строку

Для этого в Project необходимо применить запрос с функцией reduce:
```
  new_field_name: {
    $reduce: {
      input: '$field_name',
      initialValue: '',
      in: {
        $cond: [
          { $eq: ['$$value', ''] },
          '$$this',
          {
            $concat: ['$$value', ', ', '$$this']
          }
        ]
      }
    }
  }
```
где:
- `field_name` - имя поля, которое содержит массив (**не забываем про доллар!**)
- `new_field_name` - новое имя поля с объединёнными элементами массива (**придумываем сами**)
- `$concat: ['$$value', ", ", '$$this']` - здесь элемент `", "` отвечает за разделитель (в данном примере разделителем является запятая с пробелом)

Для нашего примера получится примерно следующее:
```
db.getCollection('products').find(
  {},
  {
    _id: 0,
    name: 1,
    tags_str: {
      $reduce: {
        input: '$tags',
        initialValue: '',
        in: {
          $cond: [
            { $eq: ['$$value', ''] },
            '$$this',
            {
              $concat: ['$$value', ", ", '$$this']
            }
          ]
        }
      }
    }
  }
);
```

Ожидаемый результат:
```
[{
  "name": "Laptop",
  "tags_str": "electronics, computer, portable"
},
{
  "name": "Smartphone",
  "tags_str": "electronics, mobile, portable"
},
{
  "name": "Desk",
  "tags_str": "furniture, wood, office"
},
{
  "name": "Chair",
  "tags_str": "furniture, wood"
}]
```

## 6. Универсальный запрос для объединения в строку массива с любым типом данных

Для того чтобы конкатенировать любые значения массива, их надо сначала превратить в строку.
В нашем случае, это переменная `$$this`:
```
 { $toString: "$$this" }
```

Таким образом, вот код, который объединит в строку массив с любыми типами данных
```
  new_field_name: {
    $reduce: {
      input: "$field_name",
      initialValue: "",
      in: {
        $cond: [
          { $eq: ["$$value", ""] },
          { $toString: "$$this" },
          {
            $concat: ["$$value", ", ", { $toString: "$$this" }]
          }
        ]
      }
    }
  }

```
где:
- `field_name` - имя поля, которое содержит массив (**не забываем про доллар!**)
- `new_field_name` - новое имя поля с объединёнными элементами массива (**придумываем сами**)
- `$concat: ['$$value', ", ", '$$this']` - здесь элемент `", "` отвечает за разделитель (в данном примере разделителем является запятая с пробелом)