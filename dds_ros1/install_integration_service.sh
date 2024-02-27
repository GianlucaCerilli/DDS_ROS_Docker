#!/bin/bash

echo "Installation of Integration Service"

# Install dependencies
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y \
     libyaml-cpp-dev \
     libboost-program-options-dev \
     libcurlpp-dev \
     libcurl4-openssl-dev \
     libwebsocketpp-dev

# References
# https://integration-service.docs.eprosima.com/en/latest/installation_manual/installation.html
# https://integration-service.docs.eprosima.com/en/latest/examples/different_protocols/pubsub/dds-ros2.html