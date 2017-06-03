#!/bin/bash

echo "start nginx...\n"
#/usr/sbin/nginx -g 'daemon off;'
/usr/sbin/nginx

/usr/bin/mongod --fork --quiet --logpath /var/log/mongo.log

echo "start php...\n"
php-fpm7 -F
