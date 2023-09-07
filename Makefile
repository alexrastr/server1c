#!make
include envfile
export

.PHONY: server db

all: server db

server: 
	docker build --tag rastr/server1c:${VERSION_1C} --tag rastr/server1c:latest \
		-f server/Dockerfile .

db: 
	docker build --tag rastr/postgres1c:latest \
		-f db/Dockerfile .

