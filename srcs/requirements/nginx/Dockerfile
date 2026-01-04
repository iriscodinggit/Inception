FROM alpine:3.23

RUN apk update && apk upgrade \
    && apk add vim curl openssl nginx

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html

RUN openssl req -x509 -nodes -out "/etc/nginx/ssl/inception.crt" -keyout "/etc/nginx/ssl/inception.key" -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=irlozano.42.fr/UID=irlozano"

COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/index.html /var/www/html/
COPY /conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

RUN chmod 755 /var/www/html
RUN chown -R nginx:nginx /var/www/html

CMD ["nginx", "-g", "daemon off;"]