# 🚀 Web-Marbles Production Deploy Script

## Обзор

`git_push_production.sh` - автоматизированный скрипт для развертывания Web-Marbles на Railway Services.

## 📋 Возможности

- ✅ **Автоматический коммит** всех изменений
- ✅ **Пуш в production ветку** на GitHub
- ✅ **Создание backup веток** для отката
- ✅ **Управление backup ветками** (не более 5 последних)
- ✅ **Цветной вывод** для удобства чтения
- ✅ **Проверка статуса** репозитория
- ✅ **Информативные сообщения** о Railway deployment

## 🎯 Использование

### Базовое использование
```bash
# Автоматический коммит с текущим timestamp
./git_push_production.sh

# Коммит с кастомным сообщением
./git_push_production.sh "Добавлена новая фича для игры"
```

### Примеры сообщений
```bash
./git_push_production.sh "Fix: Исправлена ошибка с WebSocket соединением"
./git_push_production.sh "Feature: Добавлена система рейтингов игроков"
./git_push_production.sh "Update: Обновлены текстуры и анимации"
```

## 🔄 Процесс работы

1. **Проверка изменений** - скрипт проверяет, есть ли изменения для коммита
2. **Добавление файлов** - `git add .` для всех изменений
3. **Создание коммита** - с указанным или автоматическим сообщением
4. **Пуш в production** - отправка изменений в production ветку
5. **Создание backup** - автоматическое создание backup ветки
6. **Очистка старых backup** - удаление backup веток старше 5 последних

## 📊 Вывод скрипта

```
🚀 Web-Marbles - Начинаем автоматический коммит и пуш в production ветку
📁 Добавляем все изменения...
📝 Создаем коммит с сообщением: 'Auto-deploy Web-Marbles: 2025-08-29 01:30:40'
✅ Коммит успешно создан
⬆️  Пушим изменения в ветку production...
✅ Успешно запушено в production ветку
💾 Создаем backup ветку: backup-20250829_013040
✅ Backup ветка создана: backup-20250829_013040
🎮 Web-Marbles готов к развертыванию на Railway
```

## 🛠️ Настройка

### Репозиторий
Скрипт настроен для работы с:
- **Репозиторий**: `https://github.com/DuMOHCTEP/games_web-marbles.git`
- **Ветка**: `production`
- **Remote**: `origin`

### Требования
- Git должен быть настроен с правильными credentials
- Доступ к репозиторию для push операций
- Выполнение из корневой папки проекта

## 🚨 Обработка ошибок

### Нет изменений
```bash
⚠️  Нет изменений для коммита
✅ Репозиторий уже актуален
```

### Ошибка коммита
```bash
❌ Ошибка при создании коммита
```

### Ошибка пуша
```bash
❌ Ошибка при пуше в production ветку
💡 Возможно, нужно сначала сделать pull:
   git pull origin production
```

## 💾 Backup система

### Автоматические backup ветки
- Создаются при каждом успешном пуше в production
- Именование: `backup-YYYYMMDD_HHMMSS`
- Хранятся последние 5 backup веток

### Восстановление из backup
```bash
# Просмотр доступных backup веток
git branch --list "backup-*"

# Переключение на backup ветку
git checkout backup-20250829_013040

# Возврат к production
git checkout production
```

## 🌐 Railway Integration

После успешного выполнения скрипта:

1. **Railway автоматически** обнаружит изменения в production ветке
2. **Начнется сборка** Docker контейнера
3. **Компиляция** нативных модулей (better-sqlite3, uWS, etc.)
4. **Развертывание** на Railway infrastructure
5. **Игра станет доступна** по Railway URL

### Railway особенности
- **Docker builder** с полной поддержкой Node.js/Python
- **Persistent volumes** для SQLite базы данных
- **Health checks** каждые 30 секунд
- **WebSocket support** для multiplayer
- **Automatic HTTPS** сертификаты

## 📝 Логи и отладка

### Просмотр истории коммитов
```bash
git log --oneline -10
```

### Проверка статуса репозитория
```bash
git status
```

### Просмотр удаленных веток
```bash
git branch -r
```

## 🎮 Production Deployment Flow

1. **Внесите изменения** в код
2. **Запустите скрипт**: `./git_push_production.sh`
3. **Railway автоматически** начнет сборку
4. **Проверьте Railway dashboard** на статус сборки
5. **Игра доступна** по Railway URL

---

**Примечание**: Скрипт полностью настроен для Web-Marbles проекта и Railway Services deployment.
