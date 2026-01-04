# DEV DOC

## Setting up the environment from scratch

1. Install Docker and Docker Compose

Follow the official Docker installation guide for your system.

Verify installation:

**docker --version**
**docker compose version**

2. Clone the repository

3. Create an .env file in the srcs/ directory, edit it and fill in the required values.

4. Create the directories used for bind mounts:

**mkdir -p /home/irlozano/data/wordpress**
**mkdir -p /home/irlozano/data/mariadb**

5. Build and run the project

**make**

The project should now be accessible at:

https://irlozano.42.fr.com

Additional information can be found in the following guide: https://tuto.grademe.fr/inception/#

## Build and launch the project

Build the Docker images and start the containers:

**make**

Note: Additional relevant commands can be found in the README.md section "Compilation".

## Relevant commands to manage containers and volumes

To build an image:

**docker build -t new_image_name .**


To see the containers running:

**docker ps**


To open a terminal in the image:

**docker run -it image_name sh**


Delete containers, images and unused resources:

**docker system prune -af**

## Identify where the project data is stored and how it persists

In this project, two bind mounts are configured:

- A bind mount for **MariaDB** that stores the WordPress database, including users, posts, comments, and hashed passwords.

- A bind mount for **WordPress** that stores website files such as themes, plugins, images and configuration files.

On the host machine, these directories are located under `/home/irlozano/data/`. Inside the containers, they are mounted at:

- `/var/lib/mysql` for MariaDB
- `/var/www/wordpress` for WordPress

Because bind mounts directly link host directories to container directories, all data persists even if the containers are stopped, removed, or rebuilt. This ensures that the database and website content are not lost when containers are recreated.