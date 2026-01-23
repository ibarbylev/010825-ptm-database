# Как подключиться к MongoDB в терминале на **Ubuntu**.

## 1. Убедитесь, что MongoDB установлена и запущена

Проверка статуса службы:

```bash
sudo systemctl status mongod
```

Запустить (если не запущена):

```bash
sudo systemctl start mongod
```

Включить автозапуск:

```bash
sudo systemctl enable mongod
```

---

## 2. Подключение к MongoDB

Если установлен `mongosh`, подключение к локальному серверу:

```bash
mongosh
```

К удалённому серверу:

```bash
mongosh "mongodb://username:password@host:27017"
```


---

## 3. Подключение к конкретной базе

```bash
mongosh "mongodb://localhost:27017/mydatabase"
```

---

## 4. Проверка подключения

После входа можно выполнить:

```js
db
show dbs
```

