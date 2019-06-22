docker build -t jorarmarfin/zabbix:4.2 .
docker build -t jorarmarfin/zabbix:4.3 .
#docker build -t drinuxsac/apache-php:tmp -f Dockerfiletmp .

docker run --name srv-zabbix -dit jorarmarfin/zabbix:base
#docker run --name srv-apache -dit drinuxsac/apache-php:tmp