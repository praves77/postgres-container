all: build push clean
.PHONY: build push clean

DOCKER = docker

POSTGRES_VER=11.3
HIVE_VER=2.3.0

HIVE_DB="metastore"
HIVE_USER="metastore"
HIVE_PASSWORD='metastore_password'


BASE_IMAGE = postgres:$(POSTGRES_VER)

IMAGE_TAG = $(POSTGRES_VER)-hive-$(HIVE_VER)
IMAGE_NAME = postgres
REGISTRY = docker.io
REPO = praves77

build:
	$(DOCKER) build \
	    --build-arg POSTGRES_VER=${POSTGRES_VER}   \
		--build-arg HIVE_VER=${HIVE_VER}           \
		--build-arg HIVE_DB=${HIVE_DB}             \
		--build-arg HIVE_USER=${HIVE_USER}         \
		--build-arg HIVE_PASSWORD=${HIVE_PASSWORD} \
		--build-arg BASE_IMAGE=${BASE_IMAGE}       \
        -t ${REGISTRY}/${REPO}/${IMAGE_NAME}:${IMAGE_TAG} .
	$(DOCKER) tag $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG) $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

push:
	# $ $(DOCKER) push $(REGISTRY)/$(REPO)/$(IMAGE_NAME)
	# $(DOCKER) push $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

clean:
	# $(DOCKER) rmi $(REGISTRY)/$(REPO)/$(IMAGE_NAME):$(IMAGE_TAG) || :
	# $(DOCKER) rmi $(REGISTRY)/$(REPO)/$(IMAGE_NAME) || :
