#Getting the os image from dockerhub
FROM debian:buster

#Getting all dependencies we need to build our image
RUN apt-get update && apt-get install -y \
	wget \
	nginx \
	openssl \
	mariadb-server \
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

#replacing nginx configuration file by my configuration
COPY ./srcs/default ./etc/nginx/sites-available
COPY ./srcs/init.sh ./

#assigning a working directory
WORKDIR /var/www/html/

#getting phpmyadmin from url into my working directory.
#then decompress ans remove tar files. 
#finally, move the directory into a clean phpmyadmin directory.
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xf phpMyAdmin-5.0.1-english.tar.gz && \
	rm -rf phpMyAdmin-5.0.1-english.tar.gz && \
	mv phpMyAdmin-5.0.1-english phpmyadmin

#same with wordpress download, decompress and remove tar files.
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	rm -rf latest.tar.gz

#Uploading my configuration files for phpmyadmin and wordpress
COPY ./srcs/config.inc.php phpmyadmin 
COPY ./srcs/wp-config.php /var/www/html/wordpress

#ssl 
RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=Paris/L=Paris/O=ddecourt/OU=42 school/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

EXPOSE 80 443

CMD bash ../../../init.sh
