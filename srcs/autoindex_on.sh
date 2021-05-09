#!/bin/bash

sed -i 's/index index.php index.html index.htm index.nginx-debian.html/index index.php index.html index.htm/;s/autoindex off/autoindex on/' /etc/nginx/sites-available/default
service nginx restart
