cmake_minimum_required(VERSION 2.8.3)
project(dds_ros1_communication)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs genmsg)

## Generate added messages and services
generate_messages(DEPENDENCIES std_msgs)

## Declare a catkin package
catkin_package()

## Build publisher and subscriber
include_directories(include ${catkin_INCLUDE_DIRS})

add_executable(ros1_dds_publisher src/ros1_dds_publisher.cpp)
target_link_libraries(ros1_dds_publisher ${catkin_LIBRARIES})
add_dependencies(ros1_dds_publisher dds_ros1_communication_generate_messages_cpp)

add_executable(ros1_dds_subscriber src/ros1_dds_subscriber.cpp)
target_link_libraries(ros1_dds_subscriber ${catkin_LIBRARIES})
add_dependencies(ros1_dds_subscriber dds_ros1_communication_generate_messages_cpp)