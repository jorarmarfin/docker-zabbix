FROM ubuntu:16.04

ENV TZ=America/Lima
ENV TERM=xterm


RUN apt-get update && apt-get -y upgrade; \
# Packages installation
DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install apache2 \
wget vim locales locales-all \
php \
php-cli \
php-gd \
php-json \
php-mbstring \
php-xml \
php-xsl \
php-zip \
php-soap \
php-pear \
php-mcrypt \
php-bcmath \
libapache2-mod-php \
curl \
php-curl \
apt-transport-https \
lynx-cur; \
a2enmod rewrite; \
phpenmod mcrypt; \
mkdir /backup;

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Update the default apache site with the config we created.
ADD config/apache/apache-virtual-hosts.conf /etc/apache2/sites-enabled/000-default.conf
ADD config/apache/apache2.conf /etc/apache2/apache2.conf
ADD config/apache/ports.conf /etc/apache2/ports.conf
ADD config/apache/envvars /etc/apache2/envvars

# Update php.ini
ADD config/php/php.ini /etc/php/7.0/apache2/php.ini

# Init
ADD init.sh /init.sh
RUN chmod 755 /*.sh \
# Add phpinfo script for INFO purposes
echo "<?php phpinfo();" >> /var/www/index.php; \
service apache2 restart; \
chown -R www-data:www-data /var/www ; 
#Instalacion de Zabbix
RUN wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1+xenial_all.deb -P /; \
dpkg -i /zabbix-release_4.2-1+xenial_all.deb; \
apt-get update; \
apt-get install -y  zabbix-frontend-php; \
apt-get install -y  zabbix-server-mysql; \
apt-get install -y  zabbix-agent;

ADD config/zabbix/apache.conf /etc/zabbix/apache.conf
ADD config/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf
ADD config/zabbix/zabbix.conf.php /usr/share/zabbix/conf/zabbix.conf.php
ADD config/zabbix/locales.inc.php /usr/share/zabbix/include/locales.inc.php

WORKDIR /var/www/

VOLUME /var/www
VOLUME /backup

EXPOSE 80
EXPOSE 10051

CMD ["/init.sh"]
