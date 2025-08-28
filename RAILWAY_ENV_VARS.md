# Railway Environment Variables

## Automatically Provided by Railway
- `PORT` - Port number for your application (automatically assigned)
- `RAILWAY_STATIC_URL` - Public URL of your Railway application

## Optional Environment Variables (can be set in Railway dashboard)
- `DATABASE_PATH` - Path to SQLite database (default: `/app/data/web-marbles.db3`)
- `NODE_ENV` - Set to 'production' for production builds
- `ROOT_URL` - Override the root URL if needed (default: constructed from PORT)
- `DISCORD_ENABLED` - Set to 'true' to enable Discord integration (requires Discord tokens)

## Setting Environment Variables in Railway

1. Go to your Railway project dashboard
2. Navigate to the "Variables" tab
3. Add the variables you need
4. Redeploy your application

## Example Configuration

```bash
NODE_ENV=production
DATABASE_PATH=/app/data/web-marbles.db3
DISCORD_ENABLED=false
```

## Database Persistence

Railway provides persistent volumes. The SQLite database will be stored in `/app/data/web-marbles.db3` and will persist between deployments.
