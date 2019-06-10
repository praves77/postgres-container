# Script to build postgres for hive and push to docker registry.
# -------------------------------------------------------

# Use env vars, if defined otherwise use defaults
# ############

POSTGRES_VER="${POSTGRES_VER:-11.3}"
HIVE_VER="${HIVE_VER:-2.3.0}"

HIVE_DB="${HIVE_DB:-metastore}"
HIVE_USER="${HIVE_USER:-metastore}"
HIVE_PASSWORD="${HIVE_PASSWORD:-metastore_password}"

# Base image of the container
# BASE_IMAGE="${BASE_IMAGE:postgres:${POSTGRES_VER}}"
BASE_IMAGE="postgres:${POSTGRES_VER}"

# #############

# image and tag
IMAGE_TAG="${POSTGRES_VER}-hive-${HIVE_VER}"
IMAGE_NAME="postgres"

# Container registry info
DOCKER=docker
REGISTRY="docker.io"
REPO="praves77"

# Debug print
echo "---------------------------"
echo "POSTGRES_VER=${POSTGRES_VER}"
echo "HIVE_VER=${HIVE_VER}"
echo "BASE_IMAGE=${BASE_IMAGE}"
echo "HIVE_DB=${HIVE_DB}"
echo "HIVE_USER=${HIVE_USER}"
echo "HIVE_PASSWORD=${HIVE_PASSWORD}"
echo "---------------------------"

# build
${DOCKER} build \
    --build-arg POSTGRES_VER=${POSTGRES_VER} \
    --build-arg HIVE_VER=${HIVE_VER} \
    --build-arg HIVE_DB=${HIVE_DB} \
    --build-arg HIVE_USER=${HIVE_USER} \
    --build-arg HIVE_PASSWORD=${HIVE_PASSWORD} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    -t ${REGISTRY}/${REPO}/${IMAGE_NAME}:${IMAGE_TAG} .

# Tag
${DOCKER} tag ${REGISTRY}/${REPO}/${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${REPO}/${IMAGE_NAME}:${IMAGE_TAG}

# push:
# ${DOCKER} push ${REGISTRY}/${REPO}/${IMAGE_NAME}:latest
${DOCKER} push ${REGISTRY}/${REPO}/${IMAGE_NAME}:${IMAGE_TAG}