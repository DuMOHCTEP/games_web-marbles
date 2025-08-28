# Multi-stage build for web-marbles
FROM node:18-alpine AS base

# Install system dependencies for better-sqlite3
RUN apk add --no-cache python3 make g++ sqlite sqlite-dev

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN yarn build

# Production stage
FROM node:18-alpine AS production

# Install system dependencies
RUN apk add --no-cache sqlite sqlite-dev

# Create app user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S webmarbles -u 1001

# Set working directory
WORKDIR /app

# Copy built application from base stage
COPY --from=base --chown=webmarbles:nodejs /app .

# Create data directory
RUN mkdir -p /app/data && chown webmarbles:nodejs /app/data

# Switch to non-root user
USER webmarbles

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "const http=require('http'); const req=http.request({hostname:'localhost',port:3000,path:'/'},res=>{process.exit(res.statusCode===200?0:1)}); req.on('error',()=>process.exit(1)); req.end();"

# Start the application
CMD ["node", "dist/web-marbles.js"]
