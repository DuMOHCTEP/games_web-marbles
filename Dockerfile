# Railway-optimized Dockerfile for web-marbles
FROM node:18-alpine

# Install system dependencies for better-sqlite3 and curl
RUN apk add --no-cache python3 make g++ sqlite sqlite-dev curl

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile --production=false

# Copy source code
COPY . .

# Build the application
RUN yarn build

# Create data directory for SQLite database
RUN mkdir -p /app/data

# Railway provides PORT environment variable
# Railway has built-in reverse proxy, so we don't need NGINX

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:$PORT/ || exit 1

# Expose port (Railway will override this)
EXPOSE 3000

# Start the application
CMD ["node", "dist/web-marbles.js"]
