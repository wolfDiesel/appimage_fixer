# Руководство для контрибьюторов

Спасибо за интерес к проекту AppImage Fixer! Мы приветствуем вклад от сообщества.

## 🚀 Быстрый старт

### Настройка окружения для разработки

```bash
# Клонируйте репозиторий
git clone https://github.com/your-username/appimage-fixer.git
cd appimage-fixer

# Создайте виртуальное окружение
python3 -m venv test_venv
source test_venv/bin/activate

# Установите зависимости для разработки
pip install -e ".[dev]"

# Установите pre-commit хуки
pre-commit install
```

### Проверка установки

```bash
# Запустите тесты
pytest

# Проверьте покрытие кода
pytest --cov=appimage_fixer --cov-report=html

# Запустите линтеры
flake8 appimage_fixer/
black --check appimage_fixer/
isort --check-only appimage_fixer/
```

## 📋 Процесс контрибьюции

### 1. Создание Issue

Перед началом работы создайте Issue для:
- Сообщения об ошибках
- Предложения новых функций
- Обсуждения архитектурных решений

### 2. Создание ветки

```bash
# Создайте ветку для ваших изменений
git checkout -b feature/amazing-feature
# или
git checkout -b fix/bug-description
```

### 3. Внесение изменений

- Пишите чистый, читаемый код
- Добавляйте комментарии к сложной логике
- Следуйте существующим соглашениям по именованию
- Обновляйте документацию при необходимости

### 4. Тестирование

```bash
# Запустите все тесты
pytest

# Запустите тесты с покрытием
pytest --cov=appimage_fixer --cov-report=term-missing

# Запустите конкретные тесты
pytest tests/test_core.py -v

# Проверьте качество кода
flake8 appimage_fixer/
black appimage_fixer/
isort appimage_fixer/
```

### 5. Создание Pull Request

1. Убедитесь, что все тесты проходят
2. Обновите документацию при необходимости
3. Создайте Pull Request с подробным описанием изменений
4. Укажите связанные Issues

## 🧪 Написание тестов

### Структура тестов

```python
import pytest
from unittest.mock import patch, MagicMock
from appimage_fixer.core import AppImageFixer

class TestAppImageFixer:
    """Test AppImageFixer functionality."""
    
    def setup_method(self):
        """Set up test fixtures."""
        self.fixer = AppImageFixer()
    
    def test_some_functionality(self):
        """Test specific functionality."""
        # Arrange
        expected = "expected_result"
        
        # Act
        result = self.fixer.some_method()
        
        # Assert
        assert result == expected
```

### Лучшие практики

- Используйте описательные имена тестов
- Тестируйте как успешные, так и неуспешные сценарии
- Используйте моки для внешних зависимостей
- Группируйте связанные тесты в классы
- Добавляйте docstrings к тестам

### Примеры тестов

```python
# Тест успешного сценария
def test_successful_operation(self):
    """Test successful operation."""
    with patch('pathlib.Path.exists', return_value=True):
        result = self.fixer.some_method()
        assert result is True

# Тест обработки ошибок
def test_error_handling(self):
    """Test error handling."""
    with patch('pathlib.Path.exists', return_value=False):
        result = self.fixer.some_method()
        assert result is False

# Тест с моками
@patch('appimage_fixer.core.subprocess.run')
def test_external_command(self, mock_run):
    """Test external command execution."""
    mock_run.return_value = MagicMock(returncode=0)
    result = self.fixer.run_external_command()
    assert result is True
```

## 📝 Документация

### Обновление документации

При добавлении новых функций обновите:

1. **README.md** - общее описание
2. **docs/USAGE.md** - подробное руководство
3. **docs/FAQ.md** - часто задаваемые вопросы
4. **Docstrings** в коде

### Стандарты документации

- Используйте Markdown для файлов документации
- Следуйте Google Style для docstrings
- Добавляйте примеры кода
- Обновляйте скриншоты при изменении UI

### Пример docstring

```python
def fix_desktop_file(self, file_path: Path) -> bool:
    """
    Fix a single desktop file.
    
    Args:
        file_path: Path to the desktop file to fix
        
    Returns:
        True if file was fixed, False otherwise
        
    Raises:
        FileNotFoundError: If desktop file doesn't exist
        PermissionError: If no write permission
        
    Example:
        >>> fixer = AppImageFixer()
        >>> result = fixer.fix_desktop_file(Path("/path/to/app.desktop"))
        >>> print(f"Fixed: {result}")
        Fixed: True
    """
```

## 🔧 Инструменты разработки

### Pre-commit хуки

Проект использует pre-commit хуки для автоматической проверки кода:

```bash
# Установка хуков
pre-commit install

# Запуск хуков вручную
pre-commit run --all-files
```

### Линтеры и форматтеры

```bash
# Проверка стиля кода
flake8 appimage_fixer/

# Автоматическое форматирование
black appimage_fixer/

# Сортировка импортов
isort appimage_fixer/

# Проверка типов (если используется mypy)
mypy appimage_fixer/
```

### Настройка IDE

#### VS Code

Создайте `.vscode/settings.json`:

```json
{
    "python.defaultInterpreterPath": "./test_venv/bin/python",
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.formatting.provider": "black",
    "python.sortImports.args": ["--profile", "black"],
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true
    }
}
```

#### PyCharm

1. Настройте интерпретатор Python на `test_venv/bin/python`
2. Включите интеграцию с flake8, black, isort
3. Настройте автоматическое форматирование при сохранении

## 🐛 Отладка

### Логирование

```python
import logging

# Настройка логирования для отладки
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def debug_function():
    logger.debug("Debug information")
    logger.info("Info message")
    logger.warning("Warning message")
    logger.error("Error message")
```

### Отладка тестов

```bash
# Запуск тестов с подробным выводом
pytest -v -s

# Запуск конкретного теста
pytest tests/test_core.py::TestAppImageFixer::test_specific_method -v -s

# Запуск с отладчиком
pytest --pdb
```

## 📊 Покрытие кода

### Требования к покрытию

- **Минимум**: 75% покрытия кода
- **Цель**: 90%+ покрытия для основных модулей
- **Исключения**: Модули интеграции с внешними системами

### Проверка покрытия

```bash
# Генерация отчета о покрытии
pytest --cov=appimage_fixer --cov-report=html

# Просмотр отчета
open htmlcov/index.html

# Проверка покрытия с минимальным порогом
pytest --cov=appimage_fixer --cov-fail-under=75
```

## 🔄 Рабочий процесс Git

### Коммиты

Используйте conventional commits:

```bash
# Новые функции
git commit -m "feat: add support for new application"

# Исправления ошибок
git commit -m "fix: resolve icon path issue"

# Документация
git commit -m "docs: update installation guide"

# Тесты
git commit -m "test: add tests for new functionality"

# Рефакторинг
git commit -m "refactor: improve error handling"
```

### Pull Request

При создании Pull Request:

1. **Заголовок**: Краткое описание изменений
2. **Описание**: Подробное описание с примерами
3. **Связанные Issues**: Укажите номера Issues
4. **Чек-лист**: Отметьте выполненные пункты

Пример описания PR:

```markdown
## Описание
Добавлена поддержка нового приложения "MyApp" с автоматическим исправлением иконок.

## Изменения
- Добавлена конфигурация для MyApp в `config.py`
- Добавлены тесты для новой функциональности
- Обновлена документация

## Тестирование
- [x] Запущены все тесты
- [x] Проверено покрытие кода (85%)
- [x] Протестировано на реальном AppImage

## Связанные Issues
Closes #123
```

## 🏷️ Версионирование

Проект следует [Semantic Versioning](https://semver.org/):

- **MAJOR**: Несовместимые изменения API
- **MINOR**: Новые функции (обратная совместимость)
- **PATCH**: Исправления ошибок

### Обновление версии

```bash
# Обновите версию в pyproject.toml
# Создайте тег
git tag v1.2.3
git push origin v1.2.3
```

## 📞 Получение помощи

### Вопросы по разработке

1. Проверьте существующие Issues и PR
2. Создайте Discussion для общих вопросов
3. Обратитесь к документации в `docs/`

### Код ревью

- Будьте конструктивными в комментариях
- Объясняйте причины отклонения
- Предлагайте альтернативные решения
- Отвечайте на комментарии своевременно

## 🎯 Рекомендации

### Для новых контрибьюторов

1. Начните с простых Issues с тегом "good first issue"
2. Изучите существующий код и тесты
3. Задавайте вопросы в Discussions
4. Не стесняйтесь просить помощи

### Для опытных разработчиков

1. Помогайте новым контрибьюторам
2. Проводите код ревью
3. Предлагайте улучшения архитектуры
4. Документируйте сложные решения

## 📄 Лицензия

Внося вклад в проект, вы соглашаетесь с тем, что ваш код будет лицензирован под MIT License.

---

**Спасибо за ваш вклад в развитие AppImage Fixer!** 🚀
