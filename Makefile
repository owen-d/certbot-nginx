TAG ?= 0.1.0
IMAGE=owend/certbot-nginx:$(TAG)

.PHONY: build
build:
	docker build -t $(IMAGE) -f src/Dockerfile src

.PHONY: run
run:
	docker run --rm -e 'DOMAINS=example.com www.example.com' -e "DRY_RUN=1" -it $(IMAGE)

.PHONY: deploy
deploy:
	docker push $(IMAGE)
