#!/bin/bash

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
exec service zabbix-server start