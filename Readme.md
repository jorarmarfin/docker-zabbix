# Docker Zabbix
* Monitoreo de servidores y webs
* Pagina de refrencia: https://www.programadornovato.com/2017/12/instalar-y-configurar-zabbix.html
* docker exec -it srv-zabbix service zabbix-server start

## Archivos de configuracion
* /usr/share/zabbix/conf/zabbix.conf.php
* /usr/share/zabbix/include/locales.inc.php

## Docker compose
```
version: '3.5'
services:
  web:
    container_name: srv-zabbix
    image: jorarmarfin/zabbix:4.2
    volumes:
      - ./zabbix/backup:/backup
    ports:
      - 9007:80
      - 10051:10051
    networks: 
      - net-zabbix
  db:
    container_name: srv-zabbix-mysql
    image: jorarmarfin/mysql:5.7-zabbix42
    environment:
      - MYSQL_ROOT_PASSWORD=root
    volumes:
      - ./mysql/data:/var/lib/mysql
      - ./mysql/conf:/etc/mysql/conf.d
      - ./mysql/backup:/backup
    networks:
      - net-zabbix
networks: 
  net-zabbix:
```