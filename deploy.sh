#!/bin/bash

echo "🚀 Starting CD deployment simulation..."

# Запускаем Docker контейнер
docker build -t cd_docker_project:latest .
docker run -d -p 5000:5000 --name cd-app cd_docker_project:latest

echo "✅ Container started on port 5000"

# Устанавливаем ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xzf ngrok-v3-stable-linux-amd64.tgz

# Настраиваем ngrok
./ngrok config add-authtoken $NGROK_AUTHTOKEN

# Создаём туннель
./ngrok http 5000 &

echo "🌐 Application available via ngrok URL"
echo "⏳ Wait 10 seconds for ngrok to initialize..."
sleep 10

# Показываем URL
curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url'
