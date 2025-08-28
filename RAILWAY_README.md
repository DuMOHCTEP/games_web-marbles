# Web-Marbles - Railway Deployment

Многопользовательская веб-игра Marble Racing, оптимизированная для развертывания на Railway Services.

## 🚀 Быстрое развертывание на Railway

### 1. Подготовка репозитория
```bash
# Клонируйте репозиторий
git clone https://github.com/DuMOHCTEP/games_web-marbles.git
cd games_web-marbles

# Перейдите на production ветку
git checkout production
```

### 2. Развертывание на Railway

#### Вариант A: Railway CLI
```bash
# Установите Railway CLI
curl -fsSL https://railway.app/install.sh | sh

# Войдите в Railway
railway login

# Инициализируйте проект
railway init marbles-game

# Подключите к репозиторию
railway link

# Разверните
railway deploy
```

#### Вариант B: Railway Dashboard
1. Перейдите на [Railway.app](https://railway.app)
2. Создайте новый проект
3. Подключите ваш GitHub репозиторий
4. Выберите ветку `production`
5. Railway автоматически обнаружит Dockerfile и развернет приложение

## 📋 Конфигурация

### Переменные окружения (опционально)
В Railway dashboard перейдите в раздел "Variables" и настройте:

| Переменная | Значение | Описание |
|------------|----------|----------|
| `NODE_ENV` | `production` | Режим production |
| `DATABASE_PATH` | `/app/data/web-marbles.db3` | Путь к базе данных |

### Автоматически предоставляемые переменные
- `PORT` - Порт, на котором работает приложение
- `RAILWAY_STATIC_URL` - Публичный URL вашего приложения

## 🗄️ База данных

Приложение использует SQLite базу данных, которая автоматически сохраняется в Railway volume:
- Путь: `/app/data/web-marbles.db3`
- Данные сохраняются между перезапусками

## 🔧 Структура проекта

```
/var/www/neonpsh.ru/games_portal/games/marbles/
├── Dockerfile              # Railway-optimized Dockerfile
├── railway.json           # Railway configuration
├── RAILWAY_ENV_VARS.md    # Environment variables documentation
├── RAILWAY_README.md      # This file
├── src/server/config.user.js  # Production configuration
├── package.json           # Node.js dependencies
├── yarn.lock             # Lock file
└── dist/                 # Built application (created during build)
```

## 🚦 Мониторинг

### Health Check
Railway автоматически проверяет здоровье приложения по пути `/`

### Логи
```bash
# Просмотр логов через Railway CLI
railway logs

# Или через Railway dashboard
# Перейдите в раздел "Logs"
```

## 🎮 Использование игры

После успешного развертывания:

1. Откройте предоставленный Railway URL
2. Игра автоматически запустится в браузере
3. Для многопользовательской игры поделитесь URL с друзьями

### Возможности игры:
- 🎯 Гонка шариков по треку
- 👥 Поддержка до 250 игроков
- 🏆 Система рейтингов
- 🎨 Кастомизация шариков
- 🛠️ Встроенный редактор уровней

## 🔄 Обновление

### Автоматическое обновление
Railway автоматически перестраивает приложение при пуше в ветку `production`

### Ручное обновление
```bash
# Создайте изменения
git add .
git commit -m "Update game features"
git push origin production
```

## 🐛 Устранение неисправностей

### Приложение не запускается
```bash
# Проверьте логи сборки
railway logs --build
```

### Проблемы с производительностью
- Проверьте использование памяти в Railway dashboard
- Увеличьте план Railway если необходимо

### Проблемы с базой данных
- База данных автоматически сохраняется в volume
- При проблемах с данными обратитесь в поддержку Railway

## 📞 Поддержка

- 📧 [GitHub Issues](https://github.com/DuMOHCTEP/games_web-marbles/issues)
- 📚 [Railway Docs](https://docs.railway.app/)
- 🎮 [Marble Racing Community](https://discord.gg/marble-racing)

## 📝 Лицензия

GPL-3.0-only - см. [LICENSE](LICENSE) файл

---

**Примечание:** Это production-ready версия игры Web-Marbles, оптимизированная для Railway Services.
