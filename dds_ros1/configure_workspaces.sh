#!/bin/bash

echo "Configuration of the workspaces, build and source"

### ROS 1 ###

# Source ROS 1 Noetic Ninjemys
echo -e "\n# Source ROS Noetic setup" >> /home/user/.bashrc
echo "source /opt/ros/noetic/setup.bash" >> /home/user/.bashrc

# Create the ROS 1 (catkin) workspace, build it and source
mkdir -p /home/user/ros1_ws/src
cd /home/user/ros1_ws/
source /opt/ros/noetic/setup.bash
catkin_make

echo -e "\n# Source the ros1_ws (catkin) setup.bash" >> /home/user/.bashrc
echo "source /home/user/ros1_ws/devel/setup.bash" >> /home/user/.bashrc

### Fast DDS ###

# Create a Fast-DDS directory
mkdir /home/user/Fast-DDS

# Clone the main repositories, checkout on compatible commits and build/install
cd /home/user/Fast-DDS
git clone https://github.com/eProsima/foonathan_memory_vendor.git
mkdir foonathan_memory_vendor/build && cd foonathan_memory_vendor/build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/ -DBUILD_SHARED_LIBS=ON
sudo cmake --build . --target install

cd /home/user/Fast-DDS
git clone https://github.com/eProsima/Fast-CDR.git -b v1.1.1
mkdir Fast-CDR/build && cd Fast-CDR/build
cmake ..
sudo cmake --build . --target install

cd /home/user/Fast-DDS
git clone https://github.com/eProsima/Fast-DDS.git -b v2.11.2
mkdir Fast-DDS/build && cd Fast-DDS/build
cmake ..
sudo cmake --build . --target install

# Source the Fast DDS libraries
echo -e "\n# Source Fast-DDS libraries" >> /home/user/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/lib/" >> /home/user/.bashrc

### Integration Service ###

# Create the Integration Service (colcon) workspace, clone the Integration-Service and System Handles repositories
mkdir -p /home/user/integration_service_ws/src
cd /home/user/integration_service_ws/src
git clone https://github.com/eProsima/Integration-Service.git --recursive
git clone https://github.com/eProsima/FastDDS-SH.git
git clone https://github.com/eProsima/ROS1-SH

cd /home/user/integration_service_ws

# The build can get stuck. The "MAKEFLAGS" and "--executor sequential" options can help
export MAKEFLAGS="-j 4"
colcon build --executor sequential

echo -e "\n# Source the integration_service_ws (colcon) setup.bash" >> /home/user/.bashrc
echo "source /home/user/integration_service_ws/install/setup.bash" >> /home/user/.bashrc