#!/bin/bash

# Скрипт для установки Git hooks

set -e

echo "🔧 Установка Git hooks..."

# Создаем директорию для hooks если её нет
mkdir -p .git/hooks

# Копируем pre-push hook
if [ -f "scripts/pre-push" ]; then
    cp scripts/pre-push .git/hooks/
    chmod +x .git/hooks/pre-push
    echo "✅ Pre-push hook установлен"
else
    echo "❌ Файл scripts/pre-push не найден"
    exit 1
fi

echo "🎉 Git hooks установлены успешно!"
echo "📝 Теперь при каждом push будут автоматически запускаться проверки качества кода"
