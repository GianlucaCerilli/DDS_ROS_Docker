#include "ros/ros.h"
#include "std_msgs/String.h"

void callback(const std_msgs::String::ConstPtr& msg)
{
  ROS_INFO("Message received from DDS: [%s]", msg->data.c_str());
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "ROS1Subscriber");

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("DDSROSTopic", 1000, callback);

  ros::spin();

  return 0;
}
