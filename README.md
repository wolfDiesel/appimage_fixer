# AppImage Fixer

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**AppImage Fixer** - это инструмент для автоматического исправления проблем с desktop файлами, созданными AppImageLauncher. Он решает распространенные проблемы с иконками и параметрами запуска Electron приложений.

## 🚀 Возможности

- 🔧 **Автоматическое исправление иконок** - убирает префиксы `appimagekit_` и исправляет ссылки на иконки
- 🛡️ **Добавление флага `--no-sandbox`** - решает проблемы с Electron приложениями

## 📋 Требования

- Python 3.8 или выше
- Linux система с поддержкой AppImage
- AppImageLauncher (опционально, для лучшей интеграции)

## 🛠️ Установка

### Из исходного кода

```bash
# Клонируйте репозиторий
git clone https://github.com/your-username/appimage-fixer.git
cd appimage-fixer

# Создайте виртуальное окружение
python3 -m venv venv
source venv/bin/activate

# Установите зависимости
pip install -e .
```

### Из PyPI (когда будет опубликовано)

```bash
pip install appimage-fixer
```

## 🎯 Использование

### Базовое использование

```bash
# Запуск с автоматическим исправлением всех найденных файлов
appimage-fixer run

# Просмотр списка найденных AppImage приложений
appimage-fixer list

# Проверка версий без внесения изменений
appimage-fixer check-versions
```

### Продвинутые команды

```bash
# Проверка статуса AppImageD интеграции
appimage-fixer check-appimaged

# Установка как системный сервис
appimage-fixer install-service

# Удаление системного сервиса
appimage-fixer uninstall-service

# Показать справку
appimage-fixer --help
```
