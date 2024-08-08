#!/bin/bash

DOCKER_IMAGE = $1

# Build and compress docker image to file tar
docker build -t $DOCKER_IMAGE .
docker save $DOCKER_IMAGE | gzip > ai_stock.tar.gz

# Copy docker image to server
scp -r ai_stock.tar.gz username@server_address:/path/

# ssh to server and run docker compose file
ssh linuxuser@$PRODUCT_SERVER_IP 'docker docker load < ai_stock.tar.gz && cd /home/linuxuser/stock  && cd /home/linuxuser/stock/ai-stock && docker compose up -d'