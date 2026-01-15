## Ошибка валидации SSL сертификатов

```
pymongo.errors.OperationFailure: certificate validation failed
```


### Решение 1: Обновить сертификаты

```bash
pip install --upgrade pymongo certifi
```


### Решение 2: Указать путь к сертификатам явно

Указать путь к файлу certifi с корневыми сертификатами:


```python
from pymongo import MongoClient
import certifi

client = MongoClient(
    "mongodb+srv://<username>:<password>@cluster0.mongodb.net/mydatabase",
    tlsCAFile=certifi.where()
)
```

### Решение 3: Вообще отключить проверку сертификатов (ТОЛЬКО НЕ ДЛЯ production!)

Указать путь к файлу `certifi` с корневыми сертификатами:


```python
from pymongo import MongoClient

client = MongoClient(
    "mongodb+srv://<username>:<password>@cluster0.mongodb.net/mydatabase",
    tlsAllowInvalidCertificates=True
)
```