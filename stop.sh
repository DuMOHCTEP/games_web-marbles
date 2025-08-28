#!/bin/bash

# Web-Marbles Docker Stop Script

echo "🛑 Stopping Web-Marbles Docker containers..."

# Stop containers
docker-compose down

# Remove volumes (optional, uncomment if needed)
# docker-compose down -v

# Remove images (optional, uncomment if needed)
# docker-compose down --rmi all

echo "✅ Web-Marbles containers stopped"
