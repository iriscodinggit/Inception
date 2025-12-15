#we don't expose 443 here, we expose it in docker compose.yml, where you also generate the SSL certificate

FROM alpine:3.22
#3.22 is currently (7-12-25) the penultimate stable version of alpine
RUN apk update
RUN apk upgrade

RUN apk add vim
RUN apk add curl
RUN apk add openssl
RUN apk add nginx
#openSSL to generate the SSL certificate

#creating necessary folders: to store certificate, nginx processes and html content
RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html

#generate the SSL certifucate
RUN openssl req -x509 -nodes -out "/etc/nginx/ssl/inception.crt" -keyout "/etc/nginx/ssl/inception.key" -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=irlozano.42.fr/UID=irlozano"

#copy conf files (i have them in the conf folder) from local virtual machine path to container path: initial webpage, php conf and nginx conf

COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/index.html /var/www/html/
#COPY /conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

#permissions: owner can do everything (the owner is set in the next line, it's called nginx and the user was created automatically when installing nginx), the rest (group, others) can't execute. All files (-R) belong to the default user called nginx

RUN chmod 755 /var/www/html
RUN chown -R nginx:nginx /var/www/html

#init nginx -g is to tell an instruction to nginx. it has to be PID 1, not as a daemon (background), since that would close the container instantly, cause containers only run as long as the PID 1 (first) process is running

CMD ["nginx", "-g", "daemon off;"]