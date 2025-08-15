# Часто задаваемые вопросы (FAQ)

## 🤔 Общие вопросы

### Что такое AppImage Fixer?

AppImage Fixer - это инструмент для автоматического исправления проблем с desktop файлами, созданными AppImageLauncher. Он решает распространенные проблемы с иконками и параметрами запуска Electron приложений.

### Зачем нужен AppImage Fixer?

AppImageLauncher создает desktop файлы с:
- Сложными именами иконок с версиями: `Icon=cursor (1.4.5)`
- Отсутствующими флагами `--no-sandbox` для Electron приложений
- Префиксами `appimagekit_` в именах файлов

AppImage Fixer автоматически исправляет эти проблемы.

### Какие приложения поддерживаются?

Поддерживаются популярные Electron и другие приложения:
- **Cursor** - AI Code Editor
- **Warp** - Modern Terminal
- **Discord** - Communication Platform
- **Visual Studio Code** - Code Editor
- **Obsidian** - Knowledge Management
- **Postman** - API Testing Tool
- **Figma** - Design Tool
- **Apidog** - API Development Platform

## 🚀 Установка и настройка

### Как установить AppImage Fixer?

```bash
# Из исходного кода
git clone https://github.com/your-username/appimage-fixer.git
cd appimage-fixer
pip install -e .

# Или через pip (когда будет опубликовано)
pip install appimage-fixer
```

### Нужны ли права администратора?

Нет, AppImage Fixer работает с правами обычного пользователя и не требует sudo для основной функциональности.

### Где хранятся файлы конфигурации?

- **Конфигурация**: `~/.local/share/appimage-fixer/`
- **Логи**: `/tmp/appimage-fixer.log` (по умолчанию)
- **База данных**: `~/.local/share/appimage-fixer/appimages.db`
- **Сервис**: `~/.config/systemd/user/`

## 🔧 Использование

### Как запустить AppImage Fixer?

```bash
# Базовый запуск
appimage-fixer run

# Предварительный просмотр
appimage-fixer run --dry-run

# Просмотр списка приложений
appimage-fixer list
```

### Что делает команда `appimage-fixer run`?

1. Находит все AppImage desktop файлы
2. Проверяет каждое приложение на необходимость исправлений
3. Исправляет иконки и добавляет флаги `--no-sandbox`
4. Обновляет системные кэши
5. Создает резервные копии перед изменениями

### Как проверить, что исправления работают?

```bash
# Запустите предварительный просмотр
appimage-fixer run --dry-run

# Проверьте логи
tail -f /tmp/appimage-fixer.log

# Запустите приложение и проверьте иконку
```

## 🔄 Автоматизация

### Как настроить автоматический запуск?

```bash
# Установите systemd сервис
appimage-fixer install-service

# Включите автозапуск
systemctl --user enable appimage-fixer.timer

# Проверьте статус
systemctl --user status appimage-fixer.timer
```

### Как часто запускается автоматическая проверка?

По умолчанию каждые 30 секунд. Можно изменить:

```bash
# Установка с пользовательским интервалом
appimage-fixer install-service --interval 120  # 2 минуты
```

### Можно ли использовать cron вместо systemd?

Да, если systemd недоступен:

```bash
# Добавьте в crontab
crontab -e

# Строка для запуска каждые 5 минут
*/5 * * * * /usr/local/bin/appimage-fixer run
```

## 🐛 Устранение проблем

### Приложение не запускается после исправления

**Возможные причины:**
1. Исправления не были нужны
2. Проблемы с правами доступа
3. Конфликт с другими настройками

**Решение:**
```bash
# Проверьте, что исправления нужны
appimage-fixer run --dry-run

# Восстановите из резервной копии
find ~/.local/share/applications -name "*.desktop.bak" -exec cp {} {}.restored \;

# Проверьте логи
tail -f /tmp/appimage-fixer.log
```

### Сервис не запускается

**Решение:**
```bash
# Проверьте статус
systemctl --user status appimage-fixer.timer

# Перезагрузите systemd
systemctl --user daemon-reload

# Переустановите сервис
appimage-fixer uninstall-service
appimage-fixer install-service
```

### Ошибка "command not found: appimage-fixer"

**Решение:**
```bash
# Проверьте установку
pip show appimage-fixer

# Добавьте ~/.local/bin в PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Ошибки прав доступа

**Решение:**
```bash
# Исправьте права на desktop файлы
chmod 644 ~/.local/share/applications/appimagekit_*.desktop

# Исправьте права на AppImage файлы
chmod +x ~/Applications/*.AppImage

# Проверьте права на конфигурацию
chmod 755 ~/.local/share/appimage-fixer/
```

## 📊 Мониторинг и диагностика

### Как проверить статус AppImageD интеграции?

```bash
appimage-fixer check-appimaged
```

### Как посмотреть логи?

```bash
# Просмотр в реальном времени
tail -f /tmp/appimage-fixer.log

# Поиск ошибок
grep "ERROR" /tmp/appimage-fixer.log

# Поиск конкретного приложения
grep "Cursor" /tmp/appimage-fixer.log
```

### Как проверить базу данных?

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

### Как проверить версии приложений?

```bash
# Проверка всех приложений
appimage-fixer check-versions

# Проверка конкретного приложения
appimage-fixer check-versions --app "Cursor"
```

## ⚙️ Конфигурация

### Как добавить поддержку нового приложения?

Отредактируйте файл `appimage_fixer/config.py`:

```python
APP_CONFIGS = {
    "MyApp": {
        "icon": "myapp-icon",
        "needs_no_sandbox": True,
        "description": "My Custom Application"
    }
}
```

### Как изменить путь к файлу логов?

```bash
# Через переменную окружения
export APPIMAGE_FIXER_LOG_FILE="/path/to/custom.log"

# Или через параметр командной строки
appimage-fixer run --log-file /path/to/custom.log
```

### Как настроить пользовательскую домашнюю директорию?

```bash
# Через переменную окружения
export APPIMAGE_FIXER_HOME_DIR="/path/to/home"

# Или через параметр командной строки
appimage-fixer run --home-dir /path/to/home
```

## 🔐 Безопасность

### Безопасно ли использовать AppImage Fixer?

Да, AppImage Fixer:
- Работает только с правами пользователя
- Создает резервные копии перед изменениями
- Не требует sudo
- Создает файлы только в пользовательских директориях

### Создаются ли резервные копии?

Да, перед любыми изменениями создаются резервные копии с расширением `.bak`.

### Можно ли отменить изменения?

Да, используя резервные копии:

```bash
# Восстановление всех файлов
find ~/.local/share/applications -name "*.desktop.bak" -exec cp {} {%.bak} \;

# Восстановление конкретного файла
cp ~/.local/share/applications/appimagekit_cursor.desktop.bak ~/.local/share/applications/appimagekit_cursor.desktop
```

## 📈 Производительность

### Сколько ресурсов использует AppImage Fixer?

AppImage Fixer использует минимальные ресурсы:
- **CPU**: Обычно менее 1% во время работы
- **Память**: Около 10-20MB
- **Диск**: Несколько мегабайт для логов и базы данных

### Как оптимизировать производительность?

```bash
# Увеличьте интервал проверки
appimage-fixer install-service --interval 300  # 5 минут

# Ограничьте область поиска
appimage-fixer run --home-dir /specific/directory
```

### Как мониторить использование ресурсов?

```bash
# Проверьте использование CPU
top -p $(pgrep -f appimage-fixer)

# Проверьте использование памяти
ps aux | grep appimage-fixer

# Проверьте размер логов
du -sh /tmp/appimage-fixer.log
```

## 🔄 Обновления

### Как обновить AppImage Fixer?

```bash
# Из исходного кода
cd appimage-fixer
git pull origin main
pip install -e . --upgrade

# Через pip
pip install --upgrade appimage-fixer
```

### Нужно ли перезапускать сервис после обновления?

Обычно нет, но можно перезапустить для уверенности:

```bash
systemctl --user restart appimage-fixer.service
```

## 📞 Поддержка

### Где получить помощь?

1. **Документация**: [docs/](docs/)
2. **Issues**: [GitHub Issues](https://github.com/your-username/appimage-fixer/issues)
3. **Discussions**: [GitHub Discussions](https://github.com/your-username/appimage-fixer/discussions)

### Как сообщить об ошибке?

При создании отчета об ошибке включите:
1. Версию приложения: `appimage-fixer --version`
2. Логи: `tail -20 /tmp/appimage-fixer.log`
3. Статус AppImageD: `appimage-fixer check-appimaged`
4. Описание проблемы и ожидаемого поведения

### Как предложить новую функцию?

Создайте Issue на GitHub с тегом "enhancement" и подробным описанием предлагаемой функции.

## 🎯 Примеры использования

### Типичный рабочий процесс

```bash
# 1. Установка
pip install appimage-fixer

# 2. Первый запуск
appimage-fixer run

# 3. Установка автоматического сервиса
appimage-fixer install-service

# 4. Проверка статуса
appimage-fixer check-appimaged
systemctl --user status appimage-fixer.timer
```

### Диагностика проблем

```bash
# Проверка всех компонентов
appimage-fixer --version
appimage-fixer check-appimaged
appimage-fixer list
appimage-fixer check-versions
tail -f /tmp/appimage-fixer.log
```

### Восстановление после проблем

```bash
# Остановка сервиса
systemctl --user stop appimage-fixer.timer

# Восстановление файлов
find ~/.local/share/applications -name "*.desktop.bak" -exec cp {} {%.bak} \;

# Перезапуск
systemctl --user start appimage-fixer.timer
```
