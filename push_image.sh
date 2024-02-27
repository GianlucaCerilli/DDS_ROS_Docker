#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"

DOCKER_REGISTRY="server-harbor:80"
RELEASE="latest"

echo -e "Pushing the Docker image $DOCKER_IMAGE_NAME\n"

if [ "$DOCKER_IMAGE_NAME" != "jammy_humble" ] && [ "$DOCKER_IMAGE_NAME" != "focal_noetic" ]
then
  echo "Docker images available: [jammy_humble, focal_noetic]"
else
  echo "You are pushing the Docker image $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE on Server Harbor. Are you sure [y/n]?"
  while true; do
    read -s -n 1 answer
    case $answer in
      y|Y)
          echo -e "[$answer] Ok, I am pushing the Docker image...\n"
          docker push $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE
          echo -e "\nDone."
          exit 0
          ;;
      n|N)
          echo "[$answer] Ok, nothing has been pushed."
          exit 0
          ;;
      *)
          echo "[$answer] Invalid input. Available [y/n]."
          ;;
    esac
  done
fi

exit