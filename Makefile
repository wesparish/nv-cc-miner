IMAGE_NAME=nv-cc-miner
NAMESPACE=wesparish/
REGISTRY=
TAG=v0.1.0

all: push

build:
	docker build -t $(REGISTRY)$(NAMESPACE)$(IMAGE_NAME):$(TAG) .

push: build
	docker push $(REGISTRY)$(NAMESPACE)$(IMAGE_NAME):$(TAG)

clean:
	docker rmi $(REGISTRY)$(NAMESPACE)$(IMAGE_NAME):$(TAG)
