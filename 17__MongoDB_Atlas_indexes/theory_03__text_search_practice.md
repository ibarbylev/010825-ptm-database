## 0. Создаём коллекцию для тестирования

```javascript
db.text_demo.insertMany([
  { name: "MongoDB is fast and scalable" },
  { name: "Full text search is useful" },
  { name: "Text indexing in MongoDB" },
  { name: "We love fast queries" },
  { name: "MongoDB text capabilities" }
]);
```

---

## 1. Создаём текстовой индекс

```javascript
db.text_demo.createIndex({ name: "text" });
```

Теперь поле `name` проиндексировано как текст.

---

## 🔍 2 Поиск текста `$text`

### 2.1. Поиск текста `$text`
#### Например, найдём документы, содержащие слово `"fast"`:

```javascript
db.text_demo.find(
  { $text: { $search: "fast" } }
);
```

Результат:
```text
"We love fast queries"
"MongoDB is fast and scalable"
```

#### Можно искать и по нескольким словам:

```javascript
db.text_demo.find(
  { $text: { $search: "MongoDB fast" } }
);
```

Результат:
```text
"We love fast queries"
"MongoDB is fast and scalable"
"MongoDB text capabilities"
"Text indexing in MongoDB"
```

#### Можно искать по слову и исключению:
```javascript
db.text_demo.find(
  { $text: { $search: "MongoDB -fast" } }
);
```

Результат:
```text
"MongoDB text capabilities"
"Text indexing in MongoDB"
```


#### Можно искать по фразе:
```javascript
db.text_demo.find(
  { $text: { $search: "\"is fast\"" } }
);
```

Результат:
```text
"We love fast queries"
"MongoDB is fast and scalable"
"MongoDB text capabilities"
"Text indexing in MongoDB"
```


Проверяем через `explain` - во всех случаях работает текстовой индекс

### 2.2. Поиск текста `$regex`

```js
db.text_demo.find({
  name: { $regex: /^Mongo/ }
});
```

Проверяем через `explain` - не работает текстовой индекс

---
## 3. Создаём обычный индекс и удаляем текстовой

```javascript
db.text_demo.createIndex({ name: 1 });
db.text_demo.dropIndex("name_text");
```


---

## 🔍 4. Поиск части текста без текстового индекса

### 4.1. Поиск с помощью `{ $text: { $search: ... }`

Запускаем
```javascript
db.text_demo.find(
  { $text: { $search: "MongoDB fast" } }
);
```
и получаем ошибку: `text index required for $text query`,  
так как конструкция `$text: {$search...` обязательно требует текстового индекса


### 4.2. Поиск с помощью `$regex: `
```javascript
db.text_demo.find({
  name: { $regex: /^Mongo/ }
});
```

Работает обычный индекс и не работает текстовой.

ПРИМЕЧАНИЕ: `$regex` не всегда использует индекс