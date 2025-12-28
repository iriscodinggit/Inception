# USER DOC

## Services provided by the stack

The stack provides three services (does it mean these services?):

- Nginx: Serves the WordPress content to your browser.

- Wordpress: Provides the website and content management system.

- MariaDB: Stores the WordPress database, including users, posts, and configurations.

## How to start and stop the project

Build the Docker images and start the containers:

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