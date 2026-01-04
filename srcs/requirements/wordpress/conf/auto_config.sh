#!/bin/sh

#wait for mariadb to start
sleep 10

if [ ! -f /var/www/wordpress/wp-config.php ]; then 
    wp config create	--allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'

#wait for the conf to apply
sleep 2

  if ! wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'; then
    echo "Error: WP configuration failed"
    exit 1
  fi

  sleep 2

#author: write and publish posts

  wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress'
fi

#socket php file
if [ ! -d /run/php ]; then
    mkdir /run/php
fi

exec php-fpm83 -F
