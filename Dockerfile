
# Download last version of ROS
FROM ros:latest

# install ros tutorials packages
RUN apt-get update && \
    apt-get install -y python-wstool
    
RUN mkdir -p catkin_ws/src/ && cd catkin_ws

COPY panther.rosinstall .
RUN wstool init src panther.rosinstall

## Error to launch this script in a dockerfile
#RUN catkin_make
   
RUN rm -rf /var/lib/apt/lists/
