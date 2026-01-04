# USER DOC

## Services provided by the stack

The stack provides three services:

- Nginx: A web server that serves the WordPress content to the client and forwards PHP requests to PHP-FPM.

- Wordpress: A content management system used to create and manage the website.

- MariaDB: A relational database used to store WordPress data such as users, posts, and settings.

## How to start and stop the project

Create your own .env file and copy it into the srcs folder. Build the Docker images and start the containers:

make

To stop the running containers:

make down

Note: Additional relevant commands can be found in the README.md section "Compilation".

## How to access the website and the administration panel

Open the browser and visit:

https://irlozano.42.fr

or

https://127.0.0.1:443

Note: Make sure to use HTTPS, as HTTP will not work. If you are not using my local machine on 42, you must edit the file C:\Windows\System32\drivers\etc\hosts so that 127.0.0.1 points to the URL indicated above.

In order to access the administration panel, check:

https://irlozano.42.fr/wp-admin

## How to locate and manage credentials

The credentials can be found on the local machine at 42 and copied into the srcs folder. They have not been uploaded to Git for security reasons.

## Check that services are running correctly

To verify that all services are running correctly, use:

docker compose ps


or check container logs with:

docker compose logs -f