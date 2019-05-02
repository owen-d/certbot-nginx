TAG ?= 0.1.0
IMAGE=owend/certbot-nginx:$(TAG)

.PHONY: build
build:
	docker build -t $(IMAGE) -f src/Dockerfile src

.PHONY: run
run:
	docker run --rm -it $(IMAGE)
