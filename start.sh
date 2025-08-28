#!/bin/bash

# Web-Marbles Docker Startup Script

set -e

echo "🚀 Starting Web-Marbles Docker containers..."

# Stop and remove existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start containers
echo "🔨 Building and starting containers..."
docker-compose up --build -d

# Wait for services to be healthy
echo "⏳ Waiting for services to start..."
sleep 10

# Check container status
echo "📊 Container status:"
docker-compose ps

# Show logs
echo "📝 Application logs:"
docker-compose logs marbles

echo "✅ Web-Marbles is running on http://localhost:8080"
echo ""
echo "📋 Useful commands:"
echo "  • View logs: docker-compose logs -f"
echo "  • Stop: docker-compose down"
echo "  • Restart: docker-compose restart"
