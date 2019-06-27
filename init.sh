#!/bin/bash

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
service zabbix-server start;
update-rc.d zabbix-server enable;