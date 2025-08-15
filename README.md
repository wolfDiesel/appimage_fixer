# AppImage Fixer

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Tests](https://github.com/wolfDiesel/appimage_fixer/workflows/CI/badge.svg)](https://github.com/wolfDiesel/appimage_fixer/actions)
[![Release](https://github.com/wolfDiesel/appimage_fixer/workflows/Release%20Package/badge.svg)](https://github.com/wolfDiesel/appimage_fixer/actions)
[![Codecov](https://codecov.io/gh/wolfDiesel/appimage_fixer/branch/main/graph/badge.svg)](https://codecov.io/gh/wolfDiesel/appimage_fixer)

**AppImage Fixer** - это инструмент для автоматического исправления проблем с desktop файлами, созданными AppImageLauncher. Он решает распространенные проблемы с иконками и параметрами запуска Electron приложений.

## 🚀 Возможности

- 🔧 **Автоматическое исправление иконок** - убирает префиксы `appimagekit_` и исправляет ссылки на иконки
- 🛡️ **Добавление флага `--no-sandbox`** - решает проблемы с Electron приложениями

## 📋 Требования

- Python 3.9 или выше
- Linux система с поддержкой AppImage
- AppImageLauncher (опционально, для лучшей интеграции)

## 🛠️ Установка

### Из исходного кода

```bash
# Клонируйте репозиторий
git clone https://github.com/wolfDiesel/appimage_fixer.git
cd appimage_fixer

# Создайте виртуальное окружение
python3 -m venv venv
source venv/bin/activate

# Установите зависимости
pip install -e .
```

### Из PyPI

```bash
pip install appimage-fixer
```

### Для разработки

```bash
# Установка с инструментами разработки
pip install -e ".[dev]"

# Установка Git hooks (рекомендуется)
./scripts/install_hooks.sh

# Запуск тестов
pytest tests/

# Проверка стиля кода
flake8 appimage_fixer/ tests/

# Проверка типов
mypy appimage_fixer/

# Форматирование кода
black appimage_fixer/ tests/
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

## 🚀 Релизы

### Автоматические релизы

Проект использует автоматизированный процесс релизов через GitHub Actions. Релизы создаются при создании тега формата `vX.Y.Z` на ветке `main`.

### Создание релиза

```bash
# Автоматический способ (рекомендуется)
./scripts/create_release.sh 1.0.0

# Ручной способ
git tag -a "v1.0.0" -m "Release v1.0.0"
git push origin main
git push origin v1.0.0
```

### Что происходит при релизе

1. ✅ **Проверка тега** - убеждается, что тег на ветке `main`
2. 🧪 **Запуск тестов** - выполняет все тесты на разных версиях Python в Linux
3. 🔍 **Проверка качества** - запускает линтеры и проверки безопасности
4. 📦 **Сборка пакета** - создает wheel и source distribution
5. 🚀 **Публикация в PyPI** - загружает пакет в PyPI
6. 🏷️ **GitHub Release** - создает релиз с описанием

Подробнее см. [Руководство по релизам](docs/RELEASES.md).