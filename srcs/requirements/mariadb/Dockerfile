FROM alpine:3.22

RUN apk update
RUN apk upgrade

RUN apk add mariadb

COPY /conf/my.cnf /etc/my.cnf
