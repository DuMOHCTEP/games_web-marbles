# Web-Marbles Docker Deployment

Это Docker-конфигурация для развертывания игры Web-Marbles (Marble Racing) в контейнерах.

## Архитектура

Проект состоит из двух контейнеров:
- **marbles**: Node.js приложение с игрой
- **nginx**: NGINX прокси-сервер для обслуживания статических файлов и проксирования запросов

## Быстрый запуск

```bash
# Запуск
./start.sh

# Остановка
./stop.sh
```

После запуска игра будет доступна по адресу: `http://localhost:8080`

## Ручной запуск

```bash
# Сборка и запуск контейнеров
docker-compose up --build -d

# Просмотр логов
docker-compose logs -f

# Остановка
docker-compose down
```

## Структура проекта

```
/var/www/neonpsh.ru/games_portal/games/marbles/
├── Dockerfile              # Docker-конфигурация для Node.js приложения
├── docker-compose.yml      # Конфигурация Docker Compose
├── nginx/
│   ├── Dockerfile          # Docker-конфигурация для NGINX
│   └── nginx.conf          # NGINX конфигурация
├── src/server/config.user.js  # Пользовательская конфигурация
├── start.sh               # Скрипт запуска
├── stop.sh                # Скрипт остановки
└── DOCKER_README.md       # Этот файл
```

## Переменные окружения

| Переменная | Значение по умолчанию | Описание |
|------------|----------------------|----------|
| `PORT` | `3000` | Порт Node.js приложения |
| `ROOT_URL` | `http://localhost/` | Корневой URL приложения |
| `NODE_ENV` | `production` | Среда выполнения |

## Мониторинг

### Health Checks
- Node.js приложение: `http://localhost:3000/` (внутри контейнера)
- NGINX: `http://localhost/health` (публичный endpoint)

### Логи
```bash
# Логи всех сервисов
docker-compose logs -f

# Логи конкретного сервиса
docker-compose logs -f marbles
docker-compose logs -f nginx
```

## Развертывание на Railway

1. Убедитесь, что Railway CLI установлен
2. Войдите в Railway: `railway login`
3. Создайте новый проект: `railway init`
4. Подключите репозиторий: `railway link`
5. Разверните: `railway deploy`

## Полезные команды

```bash
# Пересборка контейнеров
docker-compose build --no-cache

# Очистка неиспользуемых ресурсов
docker system prune -a

# Просмотр дискового пространства
docker system df

# Вход в контейнер
docker exec -it web-marbles-app sh
```

## Устранение неиспользований

### Проблема: Контейнер не запускается
```bash
# Проверьте логи
docker-compose logs marbles

# Проверьте статус контейнеров
docker-compose ps
```

### Проблема: Игра не загружается
```bash
# Проверьте health check
curl http://localhost:8080/health

# Проверьте логи NGINX
docker-compose logs nginx
```

### Проблема: WebSocket не работает
WebSocket соединения проксируются автоматически через NGINX. Если возникают проблемы:
1. Проверьте конфигурацию в `nginx/nginx.conf`
2. Убедитесь, что `proxy_buffering off` включен

## Производительность

- **NGINX**: Оптимизирован для статических файлов с gzip сжатием
- **Node.js**: Запускается в production режиме
- **База данных**: SQLite хранится в Docker volume

## Безопасность

- Контейнеры запускаются от непривилегированного пользователя
- NGINX имеет security headers
- Discord интеграция отключена в контейнере
