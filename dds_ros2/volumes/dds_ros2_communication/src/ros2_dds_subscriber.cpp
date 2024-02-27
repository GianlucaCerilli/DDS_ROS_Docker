#include <memory>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
using std::placeholders::_1;

class ROS2Subscriber : public rclcpp::Node
{
  public:
    ROS2Subscriber()
    : Node("ROS2Subscriber")
    {
      subscription_ = this->create_subscription<std_msgs::msg::String>(
      "DDSROSTopic", 10, std::bind(&ROS2Subscriber::topic_callback, this, _1));
    }

  private:
    void topic_callback(const std_msgs::msg::String & msg) const
    {
      RCLCPP_INFO(this->get_logger(), "Message received from DDS: '%s'", msg.data.c_str());
    }
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr subscription_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ROS2Subscriber>());
  rclcpp::shutdown();
  return 0;
}