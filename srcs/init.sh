#!/bin/bash

service php7.3-fpm start
service mysql start

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

if [ "$AUTOINDEX" = "on" ];
then ../../../autoindex_on.sh;
else ../../../autoindex_off.sh;
fi;

sleep infinity
#bash 
