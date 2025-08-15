# Настройка PyPI Trusted Publishing

## 🚀 Быстрое решение - API токен

Если trusted publishing не работает, используйте API токен:

### 1. Создайте API токен в PyPI:
1. Войдите в https://pypi.org/
2. Account Settings → API tokens → Add API token
3. **Scope**: Project: appimage-fixer
4. **Token name**: `appimage-fixer-github-actions`
5. Скопируйте токен

### 2. Добавьте токен в GitHub Secrets:
1. GitHub → Repository Settings → Secrets and variables → Actions
2. New repository secret:
   - **Name**: `PYPI_API_TOKEN`
   - **Value**: ваш токен из PyPI

### 3. Обновите workflow:
```yaml
- name: Publish to PyPI
  uses: pypa/gh-action-pypi-publish@release/v1
  with:
    password: ${{ secrets.PYPI_API_TOKEN }}
    skip-existing: true
```

### 4. Создайте новый релиз для тестирования

---

## Обзор

Для автоматической публикации пакетов в PyPI через GitHub Actions используется **Trusted Publishing** - новый безопасный метод аутентификации без API токенов.

## Настройка в PyPI

### 1. Войдите в PyPI
- Перейдите на https://pypi.org/
- Войдите в свой аккаунт

### 2. Перейдите в настройки проекта
- Найдите проект `appimage-fixer` в вашем аккаунте
- Или создайте новый проект, если его нет

### 3. Настройте Trusted Publisher

#### Для существующего проекта:
1. Перейдите в **Project Settings** → **Publishing** → **Trusted publishers**
2. Нажмите **Add publisher**
3. Заполните форму:
   - **Publisher name**: `appimage-fixer-github`
   - **Owner**: `wolfDiesel`
   - **Repository name**: `appimage_fixer`
   - **Workflow name**: `release.yml`
   - **Environment name**: (оставьте пустым)
   - **PyPI project name**: `appimage-fixer`

#### Для нового проекта:
1. Создайте проект в PyPI с именем `appimage-fixer`
2. Следуйте инструкциям выше для настройки trusted publisher

### 4. Проверьте настройки

Убедитесь, что в trusted publisher указаны:
- **Repository**: `wolfDiesel/appimage_fixer`
- **Workflow**: `.github/workflows/release.yml`
- **PyPI project**: `appimage-fixer`

## Проверка конфигурации

После настройки trusted publisher, при создании тега `v*.*.*`:

1. GitHub Actions запустит workflow `release.yml`
2. PyPI проверит claims из лога ошибки:
   ```
   sub: repo:wolfDiesel/appimage_fixer:ref:refs/tags/v1.2.8
   repository: wolfDiesel/appimage_fixer
   workflow_ref: wolfDiesel/appimage_fixer/.github/workflows/release.yml@refs/tags/v1.2.8
   ```

3. Если настройки совпадают, публикация пройдет успешно

## Устранение неполадок

### Ошибка "Publisher with matching claims was not found"
- Проверьте, что repository name точно совпадает: `appimage_fixer` (с подчеркиванием)
- Убедитесь, что workflow name: `release.yml`
- Проверьте, что PyPI project name: `appimage-fixer` (с дефисом)

### Ошибка "invalid-publisher"
- Убедитесь, что trusted publisher настроен для правильного PyPI проекта
- Проверьте права доступа к репозиторию

## Альтернативный метод (API Token)

Если trusted publishing не работает, можно использовать API токен:

1. Создайте API токен в PyPI:
   - Account Settings → API tokens → Add API token
   - Scope: Entire account (all projects) или Project: appimage-fixer

2. Добавьте токен в GitHub Secrets:
   - Repository Settings → Secrets and variables → Actions
   - Создайте secret `PYPI_API_TOKEN`

3. Обновите workflow:
   ```yaml
   - name: Publish to PyPI
     uses: pypa/gh-action-pypi-publish@release/v1
     with:
       password: ${{ secrets.PYPI_API_TOKEN }}
       skip-existing: true
   ```

## Полезные ссылки

- [PyPI Trusted Publishers Documentation](https://docs.pypi.org/trusted-publishers/)
- [GitHub Actions PyPI Publishing](https://github.com/pypa/gh-action-pypi-publish)
- [PyPI Project Settings](https://pypi.org/manage/project/appimage-fixer/settings/publishing/)
