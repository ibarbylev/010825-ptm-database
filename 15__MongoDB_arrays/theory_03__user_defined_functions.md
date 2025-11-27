# Пользовательcкие функции в MongoDB

**Плюсы**:
- Могут существенно упростить стандартные варианты запросов
- Более лаконичны и читабельны

**Минусы**:
- Возможность их использования может быть ограничена на сервере
- Запрещены в Atlas
- Могут работать медленнее, чем стандартные средства
- Требуется знание JS

## Синтаксис
```
{
  $function: {
    body: <function_code_as_string_or_JS_function>,
    args: [ <expression1>, <expression2>, ... ],
    lang: "js"
  }
}
```  
, где:
- `body` - тело функции
- `args` - аргументы функции (массив полей, используемых как аргументы)
- `lang` - пока ТОЛЬКО js

##  Пример
Создать новое поле `mySum`, как сумму значений двух других полей
```
{
  $project: {
    mySum: {
      $function: {
        body: function(a, b) { return a + b; },
        args: ["$field1", "$field2"],
        lang: "js"
      }
    }
  }
}
```

##  Пример
Создать новое поле `arrayAsString`, в котором собираются все элементы массива `$yourArray`
через разделитель запятая с пробелом `", "`


Если все элементы массива строки - просто джойним каждый элемент массива через `", "`:
```javascript
arrayAsString: {
  $function: {
    body: function(arr) { return arr.join(", ") },
    args: ["$yourArray"],
    lang: "js"
  }
}
```

Если нет - надо добавить `.map(String)` перед  `.join(", ")`:
```javascript
arrayAsString: {
  $function: {
    body: function(arr) { return arr.map(String).join(", ") },
    args: ["$yourArray"],
    lang: "js"
  }
}
```

Общий вид внутри стации `$project`:
```
{
  $project: {
    arrayAsString: {
      $function: {
        body: function(arr) {
          return arr.map(String).join(", ");
        },
        args: ["$yourArray"],
        lang: "js"
      }
    }
  }  
}

```

## Особенности
- Функция может быть использована ТОЛЬКО внутри стадии агрегации
- Внутри `body` доступна только стандартная JavaScript-логика, без доступа к внешним библиотекам.
- Функция должна быть чистой — без побочных эффектов, обращаться только к аргументам.
- Аргументы передаются из документа текущего шага агрегации.
- Результат функции используется как значение поля.

Дополнительная информация: [https://www.mongodb.com/docs/manual/reference/operator/aggregation/function/](https://www.mongodb.com/docs/manual/reference/operator/aggregation/function/)