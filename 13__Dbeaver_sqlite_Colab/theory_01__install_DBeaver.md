# Установка DBeaver

[https://dbeaver.io/download/](https://dbeaver.io/download/)

***

## Windows 

Скачайте `.exe` файл

***

## macOS

Скачайте `.dmg` файл

***

## Ubuntu (Установка через .deb - рекомендуется)

### 1. Скачайте `.deb`-пакет с официального сайта
```
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
```
### 2. Установите .deb-пакет
```
sudo apt install ./dbeaver-ce_latest_amd64.deb
```
### 3. Запустите DBeaver:
```
dbeaver
```

## Полезные DBeaver
### 1. Изменить настройки цвета фона и стиля:
```
Window -> Preferences -> User Interface -> Appearance -> Theme
```

### 2. Изменить размер шрифта
- шрифт интерфейса
```
Window -> Preferences -> User Interface -> Appearance -> Colors and Fonts -> DBeaver Fonts -> Main font.
```
- шрифт SQL редактора
```
Window > Preferences > User Interface > Appearance > Colors and Fonts > DBeaver Fonts > Monospace font.
```

### 3. Установка UpperCase для команд SQL

UpperCase установлен по умолчанию.
Если требуется корректировка: 
```
Window -> Preferences -> Editors -> SQL Editor -> Formatting -> KewwordCase: Upper
```