#!/bin/bash

# Local test script for Railway deployment simulation
echo "🧪 Testing Railway deployment locally..."

# Set Railway-like environment variables
export PORT=3000
export NODE_ENV=production
export RAILWAY_STATIC_URL="http://localhost:3000/"

# Build the Docker image
echo "🔨 Building Docker image..."
docker build -t web-marbles-railway .

# Run the container
echo "🚀 Starting container..."
docker run -d \
  --name web-marbles-test \
  -p 3000:3000 \
  -e PORT=3000 \
  -e NODE_ENV=production \
  -e RAILWAY_STATIC_URL="http://localhost:3000/" \
  web-marbles-railway

# Wait for startup
echo "⏳ Waiting for application to start..."
sleep 10

# Test health check
echo "🔍 Testing health check..."
if curl -f http://localhost:3000/ > /dev/null 2>&1; then
    echo "✅ Application is healthy!"
    echo "🌐 Open http://localhost:3000 in your browser"
else
    echo "❌ Application failed health check"
    echo "📝 Checking logs..."
    docker logs web-marbles-test
fi

echo ""
echo "🛑 To stop the test:"
echo "   docker stop web-marbles-test"
echo "   docker rm web-marbles-test"
