FROM alpine:3.22

RUN apk update
RUN apk upgrade

#este lo necesitamos  para obtener archivos desde links
RUN apk add wget
RUN apk add php-iconv

#instala apk y sus dependencias (si no funciona php7, es porque alpine nuevo solo acepta la 83)
RUN apk add --no-cache php83 php83-fpm php83-mysqli php83-phar mariadb-client
RUN apk add --no-cache php-phar

# download English WordPress y con -P guardas el contenido descargao en la carpeta /var/www
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www

#te vas a la carpeta donde has descargado el wordpress desde el link anterior, lo decomprimes (-xzf es xtract, zip, file : descomprimir con gzip) y borras el comprimido, ya qu eno lo necesitas porque ya lo habías descomprimido
RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

#le damos permisos de propietario (chown = changeowner) al usuario root del grupo root para poder escribir la carpeta de wordpress
RUN chown -R root:root /var/www/wordpress

#subject asks to not only install php, but also configure it (i copy my conf file www.conf)
COPY /conf/www.conf /etc/php83/php-fpm.d/www.conf

#descargamos la herramienta de línea de comandos de wordpress (un archivo .phar es un php archive)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#damos permisos de ejecución al archivo que acabamos de instalar (SI NO FUNCIONA 755 poner los permisos de la guia)
RUN chmod +x wp-cli.phar

#lo movemos a la carpeta bin (donde estan los comandos que se pueden ejecutar desde cualquier sitio, como ls, sin usar la ruta completa (como en minishell aprendi que shell buscaba si el comando estaba en esa carpeta bin))
RUN mv wp-cli.phar /usr/local/bin/wp

#la confi de wordpress de la interfaz, SI NO FUNCIONA LA RUTA CAMBAIR
COPY /conf/auto_config.sh auto_config.sh

#si no funciona 755, ya sabes
RUN chmod +x auto_config.sh

#ejecutamos el script 
ENTRYPOINT [ "sh", "auto_config.sh" ]