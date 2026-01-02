*This project has been created as part of the 42 curriculum by irlozano.*

# Inception

## Description

Inception is a project in which we learn how to use containers to build and manage a complete web infrastructure using Docker, MariaDB, WordPress, and Nginx.

Docker helps solve common environment and dependency issues, such as incompatible library versions, missing dependencies on certain operating systems or version conflicts between already installed packages. By containerizing each service, the project ensures that the application runs consistently across different systems, independently of the host environment.

### Project Description

The technologies used include:

- **Docker**: Used to containerize and orchestrate the different services of the project.
- **WordPress**: A content management system used to create and manage the website.
- **PHP-FPM**: Handles the execution of PHP code and allows Nginx to communicate with WordPress.
- **MariaDB**: A relational database used to store WordPress data such as users, posts, and settings.
- **Nginx**: A web server that serves the WordPress content to the client and forwards PHP requests to PHP-FPM.
- **Alpine Linux**: A lightweight and fast Linux distribution used to improve performance.

----

### Docker vs Virtual Machines

Containers and virtual machines (VMs) both allow multiple isolated environments to run on the same physical machine, but they operate at different levels of virtualization.

On the one hand, virtual machines implement virtualization at the hardware level. Each VM runs a complete operating system on top of a hypervisor, along with its own applications and dependencies. This provides strong isolation between systems but requires more resources, as each VM includes a full OS and consumes additional memory and CPU.

On the other hand, containers implement virtualization at the operating system level. Instead of running separate operating systems, containers share the host system’s kernel. A container consists of an application and its dependencies packaged together, ensuring that it runs consistently across different environments. Because containers do not include a full operating system, they are significantly more lightweight, faster to start, and more resource-efficient than virtual machines.

| Feature | Virtual Machines | Containers |
|--------|------------------|------------|
| Virtualization level | Hardware | Operating system |
| Includes its own OS | Yes | No |
| Kernel | Separate per VM | Shared with host |
| Resource usage | High | Low |
| Startup time | Slow (minutes) | Fast (seconds or less) |
| Isolation | Strong | Process-level isolation |
| Portability | Moderate | High |
| Typical use case | Running different operating systems | Running multiple services or applications |

----

### Secrets vs Environment Variables

A docker secret is a piece of sensitive information, such as a password, SSH key, or SSL certificate, that should not be exposed in source code, Dockerfile, or transmitted unencrypted. Docker secrets allow developers to centrally manage this data and securely provide it only to the containers that need it. Secrets are encrypted both in transit and at rest, and a secret is accessible only to the services explicitly granted access and only while those service tasks are running.

In this project, instead of using Docker secrets, I used an .env file to store environment variables. This file contains configuration values such as database credentials. To keep it secure, the .env file is not uploaded to Git and is stored locally on my machine. This approach simplifies development while maintaining reasonable security for a learning environment.

----

### Docker Network vs Host Network

In this project, a Docker bridge network is used to allow the containers to communicate with each other in an isolated environment. This approach improves security by ensuring that the services are only accessible within the internal Docker network.

On the other hand, using the host network would attach containers directly to the host’s network stack, removing network isolation and increasing the risk of port conflicts and unintended exposure of internal services.

### Docker Volumes vs Bind Mounts

Volumes and bind mounts can be used to persist data outside containers. Volumes are managed by Docker and stored in Docker’s internal directories, while bind mounts map a specific directory from the host filesystem directly into a container.

In this project, bind mounts are used to persist application data in known locations on the host system. Two bind mounts are configured:

- A bind mount for **MariaDB** that stores the WordPress database, including users, posts, comments, and hashed passwords.
- A bind mount for **WordPress** that stores website files such as themes, plugins, images and configuration files.

On the host machine, these directories are located under `/home/irlozano/data/`. Inside the containers, they are mounted at:

- `/var/lib/mysql` for MariaDB
- `/var/www/wordpress` for WordPress

Because bind mounts directly link host directories to container directories, all data persists even if the containers are stopped, removed, or rebuilt. This ensures that the database and website content are not lost when containers are recreated.

----

## Instructions  

### Prerequisites

Make sure you have the following installed on your system:

- Docker
- Make

### Compilation and make commands

Build the Docker images and start the containers:

make

To stop the running containers:

make down

To stop and remove containers, networks, and volumes:

make clean

To remove everything including images and persistent data:

make fclean

To fully rebuild the project:

make re

----

## Resources 

1. **Useful links**

- https://docs.docker.com/get-started/docker-overview/#the-docker-platform

- https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671

- https://medium.com/@imyzf/inception-3979046d90a0

- https://medium.com/@amehri_tarik/42-inception-mariadb-wordpress-nginx-bonus-29c7c8e40453

- https://dev-aditya.medium.com/pid-1-and-tini-in-docker-why-your-container-ignores-ctrl-c-800b565cb76e

- https://tuto.grademe.fr/inception/#

- https://docs.docker.com/engine/swarm/secrets/

- https://github.com/cfareste/inception?tab=readme-ov-file#121-What-is-Docker-Compose-

- https://flywp.com/blog/9281/optimize-php-fpm-settings-flywp/

- https://spinupwp.com/doc/how-php-workers-impact-wordpress-performance/

----

2. **Ethical use of AI**

AI was used to provide alternative explanations of documentation-related concepts, while always cross-checking with the original documentation. Seeing multiple perspectives on the same concept helped deepen understanding. Additionally, peer-to-peer discussions were employed to compare and validate these key concept definitions.

----

## Special Thanks

Special thanks to my 42 peers, dagimeno, msoriano and misaac-c for their support during this project.
