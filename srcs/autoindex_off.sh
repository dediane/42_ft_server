#!/bin/bash

sed -i 's/index index.php index.html index.htm/index index.php index.html index.htm index.nginx-debian.html/;s/autoindex on/autoindex off/' /etc/nginx/sites-available/default
service nginx restart
