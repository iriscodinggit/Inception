NAME	= Inception
PINK	= \033[38;5;218m
RESET := \033[0m

COMPOSE = docker compose -f srcs/docker-compose.yml

$(NAME):
	$(COMPOSE) up -d --build
	@echo "$(PINK)👨‍💻 Inception is ready! $(RESET)"

clean : 
	$(COMPOSE) down -v
	@echo "$(PINK) Inception cleaned 🧹 $(RESET)"

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