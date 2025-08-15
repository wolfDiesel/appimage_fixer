# Руководство по установке AppImage Fixer

## 📋 Требования

### Системные требования
- **ОС**: Linux (Ubuntu 20.04+, Debian 11+, Fedora 34+, Arch Linux)
- **Python**: 3.8 или выше
- **Память**: Минимум 50MB свободного места
- **Права**: Обычные пользовательские права

### Зависимости
- `sqlite3` (обычно включен в Python)
- `systemd` (для автоматического сервиса, опционально)
- `AppImageLauncher` (для лучшей интеграции, опционально)

## 🚀 Способы установки

### 1. Установка из исходного кода (рекомендуется для разработки)

```bash
# Клонируйте репозиторий
git clone https://github.com/your-username/appimage-fixer.git
cd appimage-fixer

# Создайте виртуальное окружение
python3 -m venv venv
source venv/bin/activate

# Установите в режиме разработки
pip install -e .

# Проверьте установку
appimage-fixer --version
```

### 2. Установка через pip (когда будет опубликовано)

```bash
# Установка для пользователя
pip install --user appimage-fixer

# Или глобальная установка (требует sudo)
sudo pip install appimage-fixer
```

### 3. Установка через pipx (рекомендуется для пользователей)

```bash
# Установите pipx если его нет
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Установите appimage-fixer
pipx install appimage-fixer

# Проверьте установку
appimage-fixer --version
```

## 🔧 Настройка после установки

### 1. Первоначальная настройка

```bash
# Запустите первый раз для создания базы данных
appimage-fixer run

# Проверьте статус AppImageD интеграции
appimage-fixer check-appimaged

# Посмотрите список найденных приложений
appimage-fixer list
```

### 2. Установка автоматического сервиса (опционально)

```bash
# Установите systemd сервис
appimage-fixer install-service

# Проверьте статус сервиса
systemctl --user status appimage-fixer.timer

# Включите автозапуск
systemctl --user enable appimage-fixer.timer
```

### 3. Настройка логирования

```bash
# Создайте директорию для логов
mkdir -p ~/.local/share/appimage-fixer

# Настройте переменную окружения
echo 'export APPIMAGE_FIXER_LOG_FILE="$HOME/.local/share/appimage-fixer/appimage-fixer.log"' >> ~/.bashrc
source ~/.bashrc
```

## 🧪 Проверка установки

### 1. Проверка базовой функциональности

```bash
# Проверьте версию
appimage-fixer --version

# Запустите тестовый прогон
appimage-fixer run --dry-run

# Проверьте интеграцию с AppImageD
appimage-fixer check-appimaged
```

### 2. Проверка сервиса (если установлен)

```bash
# Проверьте статус таймера
systemctl --user status appimage-fixer.timer

# Проверьте статус сервиса
systemctl --user status appimage-fixer.service

# Посмотрите логи сервиса
journalctl --user -u appimage-fixer.service -f
```

### 3. Проверка файлов

```bash
# Проверьте созданные файлы
ls -la ~/.local/share/appimage-fixer/
ls -la ~/.config/systemd/user/appimage-fixer.*

# Проверьте базу данных
sqlite3 ~/.local/share/appimage-fixer/appimages.db ".tables"
```

## 🐛 Устранение проблем установки

### Проблема: "command not found: appimage-fixer"

**Решение:**
```bash
# Проверьте, что pip установил в правильную директорию
pip show appimage-fixer

# Добавьте ~/.local/bin в PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Проблема: "Permission denied"

**Решение:**
```bash
# Установите правильные права
chmod +x ~/.local/bin/appimage-fixer

# Или переустановите с --user флагом
pip install --user appimage-fixer
```

### Проблема: "ModuleNotFoundError"

**Решение:**
```bash
# Проверьте Python версию
python3 --version

# Переустановите зависимости
pip install --upgrade --force-reinstall appimage-fixer
```

### Проблема: "systemd service not found"

**Решение:**
```bash
# Перезагрузите systemd
systemctl --user daemon-reload

# Переустановите сервис
appimage-fixer uninstall-service
appimage-fixer install-service
```

## 🔄 Обновление

### Обновление из исходного кода

```bash
cd appimage-fixer
git pull origin main
pip install -e . --upgrade
```

### Обновление через pip

```bash
pip install --upgrade appimage-fixer
```

### Обновление через pipx

```bash
pipx upgrade appimage-fixer
```

## 🗑️ Удаление

### Полное удаление

```bash
# Удалите сервис если установлен
appimage-fixer uninstall-service

# Удалите пакет
pip uninstall appimage-fixer

# Или для pipx
pipx uninstall appimage-fixer

# Удалите конфигурационные файлы
rm -rf ~/.local/share/appimage-fixer/
rm -f ~/.config/systemd/user/appimage-fixer.*
```

## 📝 Переменные окружения

| Переменная | Описание | По умолчанию |
|------------|----------|--------------|
| `APPIMAGE_FIXER_LOG_FILE` | Путь к файлу логов | `/tmp/appimage-fixer.log` |
| `APPIMAGE_FIXER_HOME_DIR` | Домашняя директория | `~` |
| `APPIMAGE_FIXER_DRY_RUN` | Режим предварительного просмотра | `false` |

## 🔐 Безопасность

### Права доступа
- AppImage Fixer работает с правами обычного пользователя
- Не требует sudo для основной функциональности
- Создает файлы только в пользовательских директориях

### Файлы и директории
- **Конфигурация**: `~/.local/share/appimage-fixer/`
- **Логи**: `/tmp/appimage-fixer.log` или настроенный путь
- **База данных**: `~/.local/share/appimage-fixer/appimages.db`
- **Сервис**: `~/.config/systemd/user/`

## 📞 Поддержка

Если у вас возникли проблемы с установкой:

1. Проверьте [FAQ](FAQ.md)
2. Создайте [Issue](https://github.com/your-username/appimage-fixer/issues)
3. Проверьте логи: `tail -f /tmp/appimage-fixer.log`
