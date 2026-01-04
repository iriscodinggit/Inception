FROM alpine:3.22

RUN apk update && apk upgrade

#iconv manages character codification
RUN apk add wget php-iconv

RUN apk add --no-cache php83 php83-fpm php83-mysqli php83-phar mariadb-client
RUN apk add --no-cache php-phar

RUN wget https://wordpress.org/wordpress-6.9.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.9.tar.gz && rm wordpress-6.9.tar.gz

RUN chown -R root:root /var/www/wordpress

#conf php pool
COPY /conf/www.conf /etc/php83/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY /conf/auto_config.sh auto_config.sh

RUN chmod +x auto_config.sh

ENTRYPOINT [ "sh", "auto_config.sh" ]
