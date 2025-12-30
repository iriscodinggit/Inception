#!/bin/sh
#1. indica qué intérprete usar (sh) para poder hacer directamente "./init_mariadb.sh" y no "sh init_mariadb.sh"

#arraca mysqld con el usuario mysql y le dice que guarde los datos en x carpeta y que el socket x es el que deben usar otros servicios (php) para conectarse a la base de datos
#el & final significa que se ejecute el comando en background (no está prohibido porqe lo hago desde CMD no ENTRYPOINT), porque si no, nunca se ejecutarían las siguientes líneas del script
mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock &

#la diferencia entre mysqld (servidor) y mysql (cliente) es que el primero es el daemon (empieza el server, procesa devuelve resultados) y el segundo es el que hace las solicitudes

#hacemos un wait para que le de tiempo a empezar el server
sleep 5

#-e es ejecuta el comando de la siguiente string
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

#localhost indica que solo puede conectarse desde la propia máquina
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#pero luego le da permisos a %. % es = a cualquier host. la razón por la que no hacmeos todo a la vez es por que no es buenas practicas, pero se puede probar a quitar localhost de antes por % a ver si funciona
## en principio se hace en dos pasos porque localhost se trata de forma especial en MySQL
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

#le cambia la contraseña al user root@localhost
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#actualiza conf
mysql -e "FLUSH PRIVILEGES;"

#Apaga temporalmente el servidor ya que la configuración inicial terminó
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

#vuelve a ejecutar el servidor pero esta vez no sé porque es más seguro. es decir, es igual que mysqld pero con algunas medidas ce seguridad como que reinicia automáticamente mysqld si se cae. (pero es un script que llama a mysqld)
exec mysqld_safe --datadir=/var/lib/mysql

#notas:

#en MySQL, los usuarios no solo se identifican por nombre, sino también por desde dónde se conectan:user@host
#Si existe otro usuario root como root@'%' o root@'127.0.0.1': Sus credenciales pueden ser distintas.
#Podrías conectarte sin contraseña desde otras IPs si esas cuentas no tienen contraseña.
#En otras palabras: MySQL trata cada combinación usuario@host como una cuenta separada. Cambiar una no afecta a las otras.

