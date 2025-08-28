# Railway Docker configuration for web-marbles
FROM node:18-alpine

# Install all system dependencies in one layer
RUN apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    make \
    g++ \
    gcc \
    sqlite \
    sqlite-dev \
    curl \
    pkgconfig \
    build-base \
    linux-headers \
    && ln -sf python3 /usr/bin/python \
    && ln -sf pip3 /usr/bin/pip

# Set environment variables for Python and node-gyp
ENV PYTHON=/usr/bin/python3
ENV PYTHONPATH=/usr/lib/python3/dist-packages
ENV NPM_CONFIG_PYTHON=/usr/bin/python3
ENV npm_config_python=/usr/bin/python3
ENV NODE_ENV=production
ENV npm_config_build_from_source=false
# Additional node-gyp configuration
ENV npm_config_node_gyp=/usr/local/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js

# Create app directory
WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json yarn.lock .npmrc ./

# Install dependencies (Python path is set via environment variables above)
RUN yarn install --frozen-lockfile --production=false

# Copy source code
COPY . .

# Build the application
RUN yarn build

# Create data directory for SQLite database
RUN mkdir -p /app/data

# Clean up build dependencies to reduce image size
RUN apk del python3-dev py3-pip build-base gcc linux-headers

# Railway provides PORT environment variable
# Railway has built-in reverse proxy, so we don't need NGINX

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:$PORT/ || exit 1

# Expose port (Railway will override this)
EXPOSE 3000

# Start the application
CMD ["node", "dist/web-marbles.js"]
