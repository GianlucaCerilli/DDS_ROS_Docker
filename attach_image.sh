#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"

DOCKER_REGISTRY="server-harbor:80"
RELEASE="latest"

echo -e "Attaching to the Docker image $DOCKER_IMAGE_NAME\n"

if [ "$DOCKER_IMAGE_NAME" != "jammy_humble" ] && [ "$DOCKER_IMAGE_NAME" != "focal_noetic" ]
then
  echo "Docker images available: [jammy_humble, focal_noetic]"
fi

DOCKER_CONTAINER_ID=$(docker ps -aqf "name=$DOCKER_IMAGE_NAME")

docker exec -it $DOCKER_CONTAINER_ID bash

exit