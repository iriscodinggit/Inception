FROM alpine:3.22
RUN apk update
RUN apk upgrade
RUN apk add vim 
RUN apk add mariadb mariadb-client
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld /var/lib/mysql
COPY /conf/my.cnf /etc/my.cnf
COPY /conf/init_mariadb.sh /init_mariadb.sh
#this gives execution permissions to everyone
RUN chmod +x /init_mariadb.sh

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
CMD [ "/init_mariadb.sh" ]