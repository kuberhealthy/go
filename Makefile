BINARY := example-check
IMAGE ?= example-check:latest

build:
	go build -o $(BINARY) ./cmd/example

docker-build:
	docker build -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

.PHONY: build docker-build docker-push
