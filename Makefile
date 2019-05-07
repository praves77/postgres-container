all: build push clean
.PHONY: build push clean

DOCKER = docker

POSTGRES_VERSION= 11.2
BASE_IMAGE = postgres:$(POSTGRES_VERSION)

IMAGE_TAG = $(POSTGRES_VERSION)-hive-3.1.0
IMAGE_NAME = postgres
REGISTRY = docker.io
REPO = praves77

build:
	$(DOCKER) build \
		--build-arg BASE_IMAGE=${BASE_IMAGE} \
		-t $(REGISTRY)/$(REPO)/$(IMAGE_NAME) .
	$(DOCKER) tag $(REGISTRY)/$(REPO)/$(IMAGE_NAME) $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

push:
	$(DOCKER) push $(REGISTRY)/$(REPO)/$(IMAGE_NAME)
	$(DOCKER) push $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

clean:
	$(DOCKER) rmi $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG) || :
	$(DOCKER) rmi $(REGISTRY)/$(REPO)/$(IMAGE_NAME) || :
