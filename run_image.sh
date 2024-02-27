#!/bin/bash

# Docker image name passed from command line
DOCKER_IMAGE_NAME="$1"

DOCKER_REGISTRY="server-harbor:80"
RELEASE="latest"

echo -e "Running the Docker image $DOCKER_IMAGE_NAME\n"

if [ "$DOCKER_IMAGE_NAME" != "jammy_humble" ] && [ "$DOCKER_IMAGE_NAME" != "focal_noetic" ]
then
  echo "Docker images available: [jammy_humble, focal_noetic]"
fi

DOCKER_IMAGE_VOLUMES="$2"

if [[ "$DOCKER_IMAGE_VOLUMES" == "-v" ]]
then
  if [[ "$DOCKER_IMAGE_NAME" == "focal_noetic" ]]
  then
    docker run --rm -it \
           -e "TERM=xterm-256color" \
           -e DISPLAY=$DISPLAY \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $HOME/dls_ws_home/dds_ros_docker/dds_ros1/volumes/dds_ros1_communication:/home/user/ros1_ws/src/dds_ros1_communication \
           -v $HOME/dls_ws_home/dds_ros_docker/dds_ros1/volumes/fastdds_ros1__communication.yaml:/home/user/integration_service_ws/src/Integration-Service/examples/basic/fastdds_ros1__communication.yaml \
           --name $DOCKER_IMAGE_NAME \
           $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE
  elif [[ "$DOCKER_IMAGE_NAME" == "jammy_humble" ]]
  then
    docker run --rm -it \
           -e "TERM=xterm-256color" \
           -e DISPLAY=$DISPLAY \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $HOME/dls_ws_home/dds_ros_docker/dds_ros2/volumes/dds_ros2_communication:/home/user/ros2_ws/src/dds_ros2_communication \
           -v $HOME/dls_ws_home/dds_ros_docker/dds_ros2/volumes/fastdds_ros2__communication.yaml:/home/user/integration_service_ws/src/Integration-Service/examples/basic/fastdds_ros2__communication.yaml \
           --name $DOCKER_IMAGE_NAME \
           $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE
  else
    echo "Docker images available: [jammy_humble, focal_noetic]"
  fi
elif [[ "$DOCKER_IMAGE_VOLUMES" == "" ]]
then
    docker run --rm -it \
           -e "TERM=xterm-256color" \
           -e DISPLAY=$DISPLAY \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           --name $DOCKER_IMAGE_NAME \
           $DOCKER_REGISTRY/dls2/$DOCKER_IMAGE_NAME:$RELEASE
else
  echo "* Available flags: [-v] to mount volumes in the Docker image"
fi

exit