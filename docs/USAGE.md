# Руководство по использованию AppImage Fixer

## 🚀 Быстрый старт

### Базовое использование

```bash
# Запуск с автоматическим исправлением всех найденных файлов
appimage-fixer run

# Просмотр списка найденных AppImage приложений
appimage-fixer list

# Проверка версий без внесения изменений
appimage-fixer check-versions
```

## 📋 Команды CLI

### Основные команды

#### `appimage-fixer run`
Запускает основной процесс исправления desktop файлов.

```bash
# Базовый запуск
appimage-fixer run

# Предварительный просмотр изменений
appimage-fixer run --dry-run

# Указание пользовательского файла логов
appimage-fixer run --log-file /path/to/custom.log

# Указание пользовательской домашней директории
appimage-fixer run --home-dir /path/to/home
```

**Опции:**
- `--dry-run` - показать что будет изменено без внесения изменений
- `--log-file PATH` - указать путь к файлу логов
- `--home-dir PATH` - указать домашнюю директорию

#### `appimage-fixer list`
Показывает список всех найденных AppImage приложений.

```bash
# Показать все найденные приложения
appimage-fixer list

# Показать с подробной информацией
appimage-fixer list --verbose
```

#### `appimage-fixer check-versions`
Проверяет соответствие версий в desktop файлах и AppImage файлах.

```bash
# Проверка всех приложений
appimage-fixer check-versions

# Проверка конкретного приложения
appimage-fixer check-versions --app "Cursor"
```

### Команды интеграции

#### `appimage-fixer check-appimaged`
Проверяет статус интеграции с AppImageD/AppImageLauncher.

```bash
# Проверка статуса
appimage-fixer check-appimaged

# Подробная информация
appimage-fixer check-appimaged --verbose
```

#### `appimage-fixer install-service`
Устанавливает systemd сервис для автоматического мониторинга.

```bash
# Установка сервиса
appimage-fixer install-service

# Установка с пользовательским интервалом
appimage-fixer install-service --interval 60
```

#### `appimage-fixer uninstall-service`
Удаляет установленный systemd сервис.

```bash
# Удаление сервиса
appimage-fixer uninstall-service
```

### Информационные команды

#### `appimage-fixer --version`
Показывает версию приложения.

```bash
appimage-fixer --version
```

#### `appimage-fixer --help`
Показывает справку по командам.

```bash
# Общая справка
appimage-fixer --help

# Справка по конкретной команде
appimage-fixer run --help
```

## 🔧 Конфигурация

### Настройка приложений

AppImage Fixer использует конфигурационный файл для определения правильных иконок и параметров для каждого приложения.

#### Добавление нового приложения

```python
# В файле appimage_fixer/config.py
APP_CONFIGS = {
    "MyApp": {
        "icon": "myapp-icon",
        "needs_no_sandbox": True,
        "description": "My Custom Application"
    }
}
```

#### Параметры конфигурации

| Параметр | Тип | Описание |
|----------|-----|----------|
| `icon` | str | Имя иконки для приложения |
| `needs_no_sandbox` | bool | Нужен ли флаг --no-sandbox |
| `description` | str | Описание приложения |

### Настройка системы

#### Переменные окружения

```bash
# Путь к файлу логов
export APPIMAGE_FIXER_LOG_FILE="/path/to/logs/appimage-fixer.log"

# Домашняя директория
export APPIMAGE_FIXER_HOME_DIR="/path/to/home"

# Режим предварительного просмотра
export APPIMAGE_FIXER_DRY_RUN="true"
```

#### Файл конфигурации

Создайте файл `~/.config/appimage-fixer/config.ini`:

```ini
[general]
log_file = /path/to/custom.log
home_dir = /path/to/home
dry_run = false

[apps]
cursor_icon = cursor
warp_icon = warp
```

## 📊 Мониторинг и логирование

### Просмотр логов

```bash
# Просмотр логов в реальном времени
tail -f /tmp/appimage-fixer.log

# Поиск ошибок
grep "ERROR" /tmp/appimage-fixer.log

# Поиск конкретного приложения
grep "Cursor" /tmp/appimage-fixer.log
```

### Структура логов

```
[2024-01-15 10:30:00] [INFO] Starting AppImage desktop file fixer with smart integration...
[2024-01-15 10:30:01] [INFO] Found 5 AppImage desktop files to check
[2024-01-15 10:30:01] [INFO] Fixed icon reference in /home/user/.local/share/applications/appimagekit_cursor.desktop
[2024-01-15 10:30:02] [INFO] Added --no-sandbox flag for Cursor
[2024-01-15 10:30:02] [INFO] Changes made, refreshing desktop database...
```

### Уровни логирования

- **INFO** - Общая информация о работе
- **WARNING** - Предупреждения (не критичные)
- **ERROR** - Ошибки, требующие внимания

## 🔄 Автоматизация

### Systemd сервис

#### Установка автоматического сервиса

```bash
# Установка сервиса
appimage-fixer install-service

# Проверка статуса
systemctl --user status appimage-fixer.timer

# Включение автозапуска
systemctl --user enable appimage-fixer.timer

# Запуск сервиса
systemctl --user start appimage-fixer.timer
```

#### Управление сервисом

```bash
# Остановка сервиса
systemctl --user stop appimage-fixer.timer

# Перезапуск сервиса
systemctl --user restart appimage-fixer.service

# Просмотр логов сервиса
journalctl --user -u appimage-fixer.service -f

# Проверка расписания
systemctl --user list-timers appimage-fixer.timer
```

#### Настройка интервалов

```bash
# Установка с пользовательским интервалом (в секундах)
appimage-fixer install-service --interval 120

# Или отредактируйте файл сервиса
nano ~/.config/systemd/user/appimage-fixer.timer
```

### Cron альтернатива

Если systemd недоступен, можно использовать cron:

```bash
# Откройте crontab
crontab -e

# Добавьте строку для запуска каждые 5 минут
*/5 * * * * /usr/local/bin/appimage-fixer run
```

## 🐛 Устранение проблем

### Частые проблемы

#### Приложения не запускаются после "исправления"

```bash
# Проверьте, что исправления действительно нужны
appimage-fixer run --dry-run

# Проверьте логи
tail -f /tmp/appimage-fixer.log

# Восстановите из резервной копии
find ~/.local/share/applications -name "*.desktop.bak" -exec cp {} {}.restored \;
```

#### Сервис не работает

```bash
# Проверьте статус
systemctl --user status appimage-fixer.timer

# Перезагрузите systemd
systemctl --user daemon-reload

# Переустановите сервис
appimage-fixer uninstall-service
appimage-fixer install-service
```

#### Ошибки прав доступа

```bash
# Проверьте права на файлы
ls -la ~/.local/share/applications/appimagekit_*

# Исправьте права
chmod 644 ~/.local/share/applications/appimagekit_*.desktop

# Проверьте права на исполняемые файлы
chmod +x ~/Applications/*.AppImage
```

### Диагностика

#### Проверка интеграции

```bash
# Проверьте AppImageD статус
appimage-fixer check-appimaged

# Проверьте найденные файлы
appimage-fixer list

# Проверьте версии
appimage-fixer check-versions
```

#### Проверка базы данных

```bash
# Откройте базу данных
sqlite3 ~/.local/share/appimage-fixer/appimages.db

# Просмотрите таблицы
.tables

# Просмотрите данные
SELECT * FROM appimages;

# Выход
.quit
```

## 📈 Производительность

### Оптимизация

#### Уменьшение интервала проверки

```bash
# Установите больший интервал для экономии ресурсов
appimage-fixer install-service --interval 300  # 5 минут
```

#### Ограничение области поиска

```bash
# Укажите конкретную директорию
appimage-fixer run --home-dir /path/to/specific/directory
```

### Мониторинг ресурсов

```bash
# Проверьте использование CPU
top -p $(pgrep -f appimage-fixer)

# Проверьте использование памяти
ps aux | grep appimage-fixer

# Проверьте размер логов
du -sh /tmp/appimage-fixer.log
```

## 🔐 Безопасность

### Права доступа

- AppImage Fixer работает только с правами пользователя
- Не требует sudo для основной функциональности
- Создает резервные копии перед изменениями

### Файлы и директории

```bash
# Проверьте созданные файлы
ls -la ~/.local/share/appimage-fixer/
ls -la ~/.config/systemd/user/appimage-fixer.*

# Проверьте права доступа
find ~/.local/share/appimage-fixer -type f -exec ls -la {} \;
```

## 📞 Поддержка

### Получение помощи

```bash
# Справка по командам
appimage-fixer --help
appimage-fixer run --help

# Проверка версии
appimage-fixer --version

# Проверка статуса
appimage-fixer check-appimaged
```

### Отчеты об ошибках

При создании отчета об ошибке включите:

1. Версию приложения: `appimage-fixer --version`
2. Логи: `tail -20 /tmp/appimage-fixer.log`
3. Статус AppImageD: `appimage-fixer check-appimaged`
4. Список приложений: `appimage-fixer list`
5. Описание проблемы и ожидаемого поведения
