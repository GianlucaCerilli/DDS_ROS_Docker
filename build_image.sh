#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"

DOCKER_IMAGE_DIR="dds_"
DOCKER_REGISTRY="server-harbor:80"
RELEASE="latest"

echo -e "Building the Docker image $DOCKER_IMAGE_NAME\n"

if [[ "$DOCKER_IMAGE_NAME" == "jammy_humble" ]]
then
  DOCKER_IMAGE_DIR+="ros2"
elif [[ "$DOCKER_IMAGE_NAME" == "focal_noetic" ]]
then
  DOCKER_IMAGE_DIR+="ros1"
else
  echo "* Missing docker image name: [jammy_humble, focal_noetic]"
fi

CACHE="$2"

if [[ "$CACHE" == "-nc" ]]
then
  docker build --no-cache --file $DOCKER_IMAGE_DIR/Dockerfile --tag $DOCKER_IMAGE_NAME:latest .
elif [[ "$CACHE" == "" ]]
then
  docker build --file $DOCKER_IMAGE_DIR/Dockerfile --tag $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE .
else
  echo "* Missing flag: [-nc] to build without considering the cache"
fi

exit