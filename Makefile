PREFIX=vidarh/
NAME=arosdev

all: build

rm:	stop
	-docker rm $(NAME)

build:
	docker build -t $(PREFIX)$(NAME) .

