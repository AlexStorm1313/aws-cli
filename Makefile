.PHONY: build run

include .env

build:
	@podman build --ssh default --skip-unused-stages --file Containerfile --target $(TARGET) --tag localhost/$(NAME):$(TAG)
	@podman image tree localhost/$(NAME):$(TAG)

run:
	@podman run --rm -it localhost/$(NAME):$(TAG)