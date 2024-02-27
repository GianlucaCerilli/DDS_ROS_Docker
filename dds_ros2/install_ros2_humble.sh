#!/bin/bash

echo "Installation of ROS2 Humble Hawksbill"

# Set UTF-8
locale
sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale

# Add the ROS 2 apt repository
sudo apt install -y software-properties-common
sudo add-apt-repository -y universe

sudo apt update
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# Install ROS 2 Humble (desktop version) and development tools
sudo apt install -y ros-humble-desktop --fix-missing
sudo apt install -y ros-dev-tools --fix-missing

# References
# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
