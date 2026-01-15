## $lookup
Стадия $lookup позволяет объединить данные из двух коллекций, аналогично операции JOIN в SQL.  
Она связывает коллекции по ключу, и результат добавляется в новый массив.

### Ключевое отличие $lookup от SQL JOIN: 
В MongoDB результат `$lookup` представляет собой массив документов из связанной коллекции,   
а не простое добавление полей.  
Если для каждой записи из исходной коллекции найдены несколько записей в связанной коллекции,   
то в итоговом документе будет массив этих записей.

*Пример:*
```
db.getCollection('restaurants').aggregate(
  [
    {
      $lookup: {
        from: 'restaurants',
        localField: '_id',
        foreignField: 'restaurant_id',
        as: 'restaurantInfo'
      }
    }
  ]
```

| Поле           | Значение         | Что значит                                     |
| -------------- |------------------|------------------------------------------------|
| `from`         | `restaurants`    | В какую коллекцию "смотреть" для поиска данных |
| `localField`   | `_id`            | Поле из текущей коллекции                      |
| `foreignField` | `restaurant_id`  | Поле из коллекции `from`, с которым сравнивать |
| `as`           | `restaurantInfo` | Имя нового поля, в которое добавится результат |

В этом примере все данные коллекции `restaurants` добавятся к соответствующим документам  
текущей коллекции именно как элементы массива `restaurantInfo`.

## $set
Обычно, следующим шагом новый массив "достаётся" командой (стадией) `$unwind`  
и вся добавленная коллекция становится объектом внутри документа существующей коллекции. 

```
db.getCollection('restaurants').aggregate(
  [
    {
      $lookup: {
        from: 'restaurants',
        localField: '_id',
        foreignField: 'restaurant_id',
        as: 'restaurantInfo'
      }
    },
    { 
      $unwind: { path: '$restaurantInfo' } 
    },

  ]
```
Теперь к добавленным данным можно обращаться как к полноценным полям.
И далее в этот объект переносятся все необходимые поля из существующей коллекции с помощью команды (стадии) `$set`.

```
db.getCollection('restaurants').aggregate(
  [
    {
      $lookup: {
        from: 'restaurants',
        localField: '_id',
        foreignField: 'restaurant_id',
        as: 'restaurantInfo'
      }
    },
    { 
      $unwind: { path: '$restaurantInfo' } 
    },
    {
      $set: {
        'restaurantInfo.avgScore': '$avgScore',
        'restaurantInfo.totalReviews':
          '$totalReviews'
      }
    }
  ]
```
## $replaceRoot
Обычно следующим этапом идёт именно эта команда (стадия) `$replaceRoot`.
В результате чего новый объект становится основным документом (а данные основного документа при этом удаляются)

```
db.getCollection('restaurants').aggregate(
  [
    {
      $lookup: {
        from: 'restaurants',
        localField: '_id',
        foreignField: 'restaurant_id',
        as: 'restaurantInfo'
      }
    },
    { 
      $unwind: { path: '$restaurantInfo' } 
    },
    {
      $set: {
        'restaurantInfo.avgScore': '$avgScore',
        'restaurantInfo.totalReviews':
          '$totalReviews'
      }
    },
    {
      $replaceRoot: { newRoot: '$restaurantInfo' }
    },

  ]
```

(Более подробный пример будет рассмотрен при решении задачи 4)