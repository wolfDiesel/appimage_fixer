#!/bin/bash

# Скрипт для создания релиза AppImage Fixer
# Использование: ./scripts/create_release.sh <version>
# Пример: ./scripts/create_release.sh 1.0.0

set -e

# Проверка аргументов
if [ $# -eq 0 ]; then
    echo "❌ Ошибка: Не указана версия"
    echo "Использование: $0 <version>"
    echo "Пример: $0 1.0.0"
    exit 1
fi

VERSION=$1

# Проверка формата версии
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Ошибка: Неверный формат версии. Используйте формат X.Y.Z"
    exit 1
fi

echo "🚀 Создание релиза v$VERSION..."

# Проверка, что мы на ветке main
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "❌ Ошибка: Вы должны быть на ветке main для создания релиза"
    echo "Текущая ветка: $CURRENT_BRANCH"
    exit 1
fi

# Проверка, что нет незакоммиченных изменений
if ! git diff-index --quiet HEAD --; then
    echo "❌ Ошибка: Есть незакоммиченные изменения"
    echo "Пожалуйста, закоммитьте или отмените изменения перед созданием релиза"
    exit 1
fi

# Обновление версии в __init__.py
echo "📝 Обновление версии в __init__.py..."
sed -i "s/__version__ = \".*\"/__version__ = \"$VERSION\"/" appimage_fixer/__init__.py

# Обновление CHANGELOG.md
echo "📝 Обновление CHANGELOG.md..."
TODAY=$(date +%Y-%m-%d)
sed -i "s/## \[Unreleased\]/## [Unreleased]\n\n## [$VERSION] - $TODAY/" CHANGELOG.md

# Коммит изменений
echo "💾 Коммит изменений..."
git add appimage_fixer/__init__.py CHANGELOG.md
git commit -m "Bump version to $VERSION"

# Создание тега
echo "🏷️ Создание тега v$VERSION..."
git tag -a "v$VERSION" -m "Release v$VERSION"

# Отправка изменений и тега
echo "📤 Отправка изменений и тега..."
git push origin main
git push origin "v$VERSION"

echo "✅ Релиз v$VERSION успешно создан!"
echo "📦 GitHub Actions автоматически соберет и опубликует пакет"
echo "🔗 Следите за прогрессом: https://github.com/wolfDiesel/appimage_fixer/actions"
