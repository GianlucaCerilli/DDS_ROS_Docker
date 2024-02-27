#!/bin/bash

echo "Installation of ROS Noetic Ninjemys"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y ros-noetic-desktop-full --fix-missing

# Dependencies for building packages (other than ROS core packages)
sudo apt install -y \
     python3-rosdep \
     python3-rosinstall \
     python3-rosinstall-generator \
     python3-wstool \
     python3-catkin-tools \
     python3-osrf-pycommon

sudo rosdep init
rosdep update

# References
# http://wiki.ros.org/noetic/Installation/Ubuntu