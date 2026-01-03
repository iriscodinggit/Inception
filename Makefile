NAME	= Inception
PINK	= \033[38;5;218m
RESET := \033[0m
#replace wherever you see COMPOSE with this file:
COMPOSE = docker compose -f srcs/docker-compose.yml

#up creates the containers, -d detached so that you can keep using the terminal and build rebuilds the images if there have been changes
$(NAME):
	$(COMPOSE) up -d --build
	@echo "$(PINK)👨‍💻 Inception is ready! $(RESET)"

#down removes the network and containers created by up, and the volumes because of -v

clean : 
	$(COMPOSE) down -v
	@echo "$(PINK) Inception cleaned 🧹 $(RESET)"

#like clean but it also deletes the images of containers that are not running, located in /var/lib/docker/. -a de all y -f force (sin pedir confirmación)
fclean : clean
	docker system prune -af --volumes
	rm -rf /home/irlozano/data/wordpress/*
	rm -rf /home/irlozano/data/mariadb/*
	@echo "$(PINK) Inception cleaned 🧹 $(RESET)"

down:
	$(COMPOSE) down
	@echo "$(PINK)Inception stopped 🛑$(RESET)"

all : $(NAME)

re: fclean all

.PHONY: clean all re fclean
