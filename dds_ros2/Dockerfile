# Install Ubuntu 22.04 LTS Jammy Jellyfish
FROM ubuntu:22.04

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
    iputils-ping \
    net-tools \
    nano \
    dbus-x11 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    at-spi2-core \
    gedit \
    htop \
    mlocate \
    wget \
    git \
    libeigen3-dev \
    libgtest-dev

RUN echo "\n### Jammy Humble docker image ###" >> /home/user/.bashrc

# To make gedit work (installation of "dbus-x11", "at-spi2-core", "libcanberra-gtk-module", "libcanberra-gtk3-module" and this export)
RUN echo "\n# Export variables for gedit" >> /home/user/.bashrc
RUN echo "export \$(dbus-launch)" >> /home/user/.bashrc

# Install ROS 2 Humble Hawksbill
ADD dds_ros2/install_ros2_humble.sh ${WORKDIR}
RUN ["/home/user/install_ros2_humble.sh"]

# Install Fast DDS
ADD dds_ros2/install_fastdds.sh ${WORKDIR}
RUN ["/home/user/install_fastdds.sh"]

# Install eProsima Integration Service
ADD dds_ros2/install_integration_service.sh ${WORKDIR}
RUN ["/home/user/install_integration_service.sh"]

# Add the user "user" to the sudo group
RUN adduser user sudo

# Add a line to the "/etc/sudoers" file that allows all users in the sudo group to run all commands without a password
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER user

# Configure ROS 2, Fast DDS and Integration Service workspaces 
ADD dds_ros2/configure_workspaces.sh ${WORKDIR}
RUN ["/home/user/configure_workspaces.sh"]

RUN . /home/user/.bashrc

# Remove the installation scripts and Fast DDS folder from the image
RUN rm /home/user/install_ros2_humble.sh
RUN rm /home/user/install_fastdds.sh
RUN rm /home/user/install_integration_service.sh
RUN rm /home/user/configure_workspaces.sh
RUN sudo rm -rf /home/user/Fast-DDS