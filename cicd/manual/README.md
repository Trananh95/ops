# CI/CD manual 

## Luồng triển khai dự án manual:
* Dev self test khi code xong một feature 
* Dev commit code 
* Dev push/pull_request code 
* Dev build docker image
* Dev upload docker image lên server
* Dev chỉnh sửa lại file docker-compose.yml và run file
* Dev quan sát log để check lỗi


<img loading="lazy" width="800px" src="./manual_flow.png" alt="Manual Flow" />

## Luồng triển khai tự động

* Auto build docker image với tên image đã được đánh tag mới
* Auto upload image lên server
* Auto thay đổi tên image mới trong file docker-compose
* Auto run file


## Tạo script auto deploy:
 Khởi tạo file bash hỗ trợ việc auto deploy service trên server sau khi push code

```
#!/bin/bash

DOCKER_IMAGE = $1

# Build and compress docker image to file tar
docker build -t $DOCKER_IMAGE .
docker save $DOCKER_IMAGE | gzip > ai_stock.tar.gz

# Copy docker image to server
scp -r ai_stock.tar.gz username@server_address:/path/

# ssh to server and run docker compose file
ssh linuxuser@$PRODUCT_SERVER_IP 'docker docker load < ai_stock.tar.gz && cd /home/linuxuser/stock  && cd /home/linuxuser/stock/ai-stock && docker compose up -d'
```

Trong đó:
* DOCKER_IMAGE: là tên của docker image sau khi được đánh tag mới