#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"

using namespace std::chrono_literals;

/* This example creates a subclass of Node and uses std::bind() to register a
* member function as a callback from the timer. */

class ROS2Publisher : public rclcpp::Node
{
  public:
    ROS2Publisher()
    : Node("ROS2Publisher"), count_(0)
    {
      publisher_ = this->create_publisher<std_msgs::msg::String>("DDSROSTopic", 10);
      timer_ = this->create_wall_timer(
      500ms, std::bind(&ROS2Publisher::timer_callback, this));
    }

  private:
    void timer_callback()
    {
      auto message = std_msgs::msg::String();
      message.data = "ROS1 publishing a message for DDS subscriber " + std::to_string(count_++);
      RCLCPP_INFO(this->get_logger(), "'%s'", message.data.c_str());
      publisher_->publish(message);
    }
    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
    size_t count_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<ROS2Publisher>());
  rclcpp::shutdown();
  return 0;
}