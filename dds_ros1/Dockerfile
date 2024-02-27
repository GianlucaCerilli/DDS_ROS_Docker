# Install Ubuntu 20.04.6 LTS Focal Fossa
FROM ubuntu:20.04

# Add a user "user", create its home directory and ensure that bash is set as default shell
RUN useradd -ms /bin/bash user

# Create a working directory
WORKDIR /home/user

# Set the non-interactive debian frontend
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update, upgrade and install apt packages
RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install -y \
    --no-install-recommends \
    sudo \
    cmake \
    g++ \
    python3-pip \
    build-essential \
    apt-utils \
    curl \
    bash-completion \
    lsb-release \
    gnupg2 \
    iputils-ping \
    net-tools \
    nano \
    dbus-x11 \
    gedit \
    htop \
    mlocate \
    wget \
    git \
    libeigen3-dev \
    libgtest-dev

RUN echo "\n### Focal Noetic docker image ###" >> /home/user/.bashrc

# To make gedit work (installation of dbus-x11 and this export)
RUN echo "\n# Export variables for gedit" >> /home/user/.bashrc
RUN echo "export \$(dbus-launch)" >> /home/user/.bashrc

# Install ROS 1 Noetic Ninjemys
ADD dds_ros1/install_ros_noetic.sh ${WORKDIR}
RUN ["/home/user/install_ros_noetic.sh"]

# Install Fast DDS
ADD dds_ros1/install_fastdds.sh ${WORKDIR}
RUN ["/home/user/install_fastdds.sh"]

# Install eProsima Integration Service
ADD dds_ros1/install_integration_service.sh ${WORKDIR}
RUN ["/home/user/install_integration_service.sh"]

# Add the user "user" to the sudo group
RUN adduser user sudo

# Add a line to the "/etc/sudoers" file that allows all users in the sudo group to run all commands without a password
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER user

# Configure ROS 1, Fast DDS and Integration Service workspaces 
ADD dds_ros1/configure_workspaces.sh ${WORKDIR}
RUN ["/home/user/configure_workspaces.sh"]

RUN . /home/user/.bashrc

# Remove the installation scripts and Fast DDS folder from the image
RUN rm /home/user/install_ros_noetic.sh
RUN rm /home/user/install_fastdds.sh
RUN rm /home/user/install_integration_service.sh
RUN rm /home/user/configure_workspaces.sh
RUN sudo rm -rf /home/user/Fast-DDS