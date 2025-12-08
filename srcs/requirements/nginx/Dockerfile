#do i need to expose 443 ? no you expose it in docker compose.yml, where you also generate the SSL certifucate

FROM alpine:3.22
#3.22 is currently (7-12-25) the penultimate stable version of alpine
RUN apk update
RUN apk upgrade

RUN apk add vim
RUN apk add curl
RUN apk add openssl
#openSSL to generate the SSL certificate

#creating necessary folders: to store certificate, nginx processes and html content
RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html

#generate the SSL certifucate
RUN openssl req -x509 -nodes -out "/etc/nginx/ssl/inception.crt" -keyout "/etc/nginx/ssl/inception.key" -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=irlozano.42.fr/UID=irlozano"

#copy conf files (i have them in the conf folder) from local virtual machine path to container path: initial webpage, php conf and nginx conf

COPY /conf/index.html /var/www/html/
COPY /conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
COPY /conf/nginx.conf /etc/nginx/nginx.conf

#permissions: owner can do everything, the rest can't write. all files (-R) belong to the default user nginx

RUN chmod 755 /var/www/html
#FIX ERROR: if i uncomment it, error -> change for www-data:www-data /var/www/html as the guide says?
#RUN chown -R nginx:nginx /var/www/html

#init nginx. -g is to tell an instruction to nginx. it has to be PID 1, not as a daemon (background), since that would close the container instantly

CMD ["nginx", "-g", "daemon off;"]