cmake_minimum_required(VERSION 3.8)
project(dds_ros2_communication)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 20)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)

add_executable(ros2_dds_publisher src/ros2_dds_publisher.cpp)
ament_target_dependencies(ros2_dds_publisher rclcpp std_msgs)

add_executable(ros2_dds_subscriber src/ros2_dds_subscriber.cpp)
ament_target_dependencies(ros2_dds_subscriber rclcpp std_msgs)

install(TARGETS
  ros2_dds_publisher
  ros2_dds_subscriber
  DESTINATION lib/${PROJECT_NAME})

ament_package()