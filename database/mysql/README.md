# Practice with MySQL on a Server

## 1. Install MySQL
### Via docker compose
* Docker compose file:
```
version: "3.8"
services:
  mysql:
    image: mysql:5.7
    container_name: mysql-5.7
    restart: always                       # always restart
    environment:
      MYSQL_DATABASE: 'test'              # name of database
      MYSQL_USER: 'sample'                # sample is the name of user
      MYSQL_PASSWORD: 'password'          # password for sample user
      MYSQL_ROOT_PASSWORD: 'password'     # password for root user
    ports:
      - '3306:3306'                       # host port 3306 is mapper to docker port 3306
    expose:
      - '3306'
    volumes:
      - /path/on/host:/var/lib/mysql
      #- ./database_dump.sql:/docker-entrypoint-initdb.d/datadump.sql


```

* Install:
    `docker-compose up -d`

### Via Kubernet


## 2. Import data from sql dump file

### Via docker compose
All dumps that are found in the **/docker-entrypoint-initdb.d** directory of the image will be imported unless the database already contains data.
So let’s add this volume to our docker-compose.yaml
`volumes: - ./database_dump.sql:/docker-entrypoint-initdb.d/datadump.sql`

### Via kubernet

## 3. Backup data
### Via docker
`docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql`
### Via Kuvernet





