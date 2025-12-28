#!/bin/sh
#lo de arriba no es necesario, pero así puedes ejecutar sin sh porque ya le dices el compilador (aunque yo en entrypoint lo hago con sh, probar con ./auto_config.sh)


#these two just for debugging, prints the commands  and variables(delete after)
set -x

#give some time for mariadb to start
sleep 10

echo $SQL_DATABASE $DOMAIN_NAME $SQL_USER $USER1_LOGIN

#si no existe aún la file (para no configurarla si ya existe)
if [ ! -f /var/www/wordpress/wp-config.php ]; then 
    #generate the wp_config.sh file and allow root to create it (wp-cli has a special safety check that doesnt let root run it by default, so we have to explicitly tell them you can do it). The path at the end tells wp-cli where wordpress is installed to search for the files here
    wp config create	--allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'

#small pause to configure
sleep 2

#imp: no es una instalación, es para configurar la interfaz con la database y el usuario. si falla, imprimir mensaje de error
  if ! wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'; then
    echo "Error: wp core install failed"
    exit 1
  fi
#fi is the closing keyword of an if loop in bash

#small pause to insstall wp core
  sleep 2

#create the second user that the subjects asks for and saves the data is log.txt1.
#WordPress has user roles: subscriber, contributor, author, editor, administrator,--role=author means the user can:Write and publish their own posts
  wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log_user_wp.txt
#delete the log part its just fot debugging
fi
#if the file where the sockets are doesnt exist, create it. we need it cause nginx communicates with php through sockets and the socket files are generated in that path
#-d is to check that it's a directory
if [ ! -d /run/php ]; then
    mkdir /run/php
fi

#php-fpm es el main process de este container. hay que ejecutar php de fondo para esperar requests (no se ejecutaba en el container de nginx -> no). si no haces foreground se ejecutaria como daemon y el container se cerraria, porque se cierra cuando el main process acaba
exec php-fpm83 -F