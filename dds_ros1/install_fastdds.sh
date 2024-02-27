#!/bin/bash

echo "Installation of FAST DDS"

# Install dependencies
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y \
     libasio-dev \
     libtinyxml2-dev \
     libssl-dev \
     openjdk-11-jdk

# Install Colcon
pip3 install -U colcon-common-extensions vcstool colcon-gradle  

# References
# https://fast-dds.docs.eprosima.com/en/latest/installation/sources/sources_linux.html