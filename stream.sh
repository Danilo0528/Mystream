#!/bin/bash

# Configuración de variables
VIDEO_FILE="${VIDEO_FILE:-rickroll.mp4}"
YOUTUBE_KEY="${YOUTUBE_KEY:-#!/bin/bash

echo "YOUTUBE_KEY=$YOUTUBE_KEY"
echo "VIDEO_FILE=$VIDEO_FILE"
echo "SERVER_PORT=$SERVER_PORT"
# ...código existente...-youtube-code}"
SERVER_PORT="${PORT:-8080}"

# Instalar dependencias necesarias
apt-get update && apt-get install -y ffmpeg nginx

# Configurar nginx para servir el archivo de video
mkdir -p /var/www/html
cp "$VIDEO_FILE" /var/www/html/video.mp4

cat > /etc/nginx/sites-available/default << EOF
server {
    listen $SERVER_PORT default_server;
    listen [::]:$SERVER_PORT default_server;
    
    root /var/www/html;
    
    location / {
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Iniciar nginx
service nginx start

# Iniciar la transmisión a YouTube
#ffmpeg -stream_loop -1 \
#    -re -i "http://localhost:$SERVER_PORT/video.mp4" \
#    -c:v libx264 -preset veryfast -maxrate 3000k -bufsize 6000k -g 50 \
#    -c:a aac -b:a 160k -ar 44100 \
#    -f flv "rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY"

 ffmpeg -stream_loop -1 \
     -re -i "http://localhost:$SERVER_PORT/video.mp4" \
     -c:v libx264 -preset ultrafast -maxrate 600k -bufsize 6000k -g 50 \
     -c:a aac -b:a 128k -ar 44100 \
     -f flv "rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY"

# ffmpeg -stream_loop -1 \
#     -re -analyzeduration 200M -probesize 200M \
#     -i "http://localhost:$SERVER_PORT/video.mp4" \
#     -s 854x480 -r 24 \
#     -c:v libx264 -preset ultrafast -b:v 1000k -maxrate 1000k -bufsize 4000k -g 48 \
#     -c:a aac -b:a 96k -ar 44100 \
#     -f flv "rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY"


#ffmpeg -stream_loop -1 \
#  -re -i "http://localhost:$SERVER_PORT/video.mp4" \
#  -s 640x360 -r 20 \
#  -c:v libx264 -preset ultrafast -tune zerolatency -b:v 700k -maxrate 700k -bufsize 2800k -g 40 \
#  -c:a aac -b:a 128k -ar 44100 \
#  -f flv "rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY"




    


    
