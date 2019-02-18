# Panther docker installer
# Fix layers with https://www.fromlatest.io

# Download last version of ROS
# https://hub.docker.com/_/ros?tab=description
FROM ros:melodic-robot

# install ros tutorials packages
#RUN apt-get update \
#    && apt-get install --no-install-recommends -y \
#       python-wstool \
#    && rm -rf /var/lib/apt/lists/* 

# Make catkin workspace
RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/

# Copy panther rosinstall in docker
COPY panther.rosinstall .

# Install all paths and download all required packages
# Launch catkin_make
# https://answers.ros.org/question/312577/catkin_make-command-not-found-executing-by-a-dockerfile/
#RUN wstool init ~/catkin_ws/src panther.rosinstall \
#    && rosdep install -y --from-paths ~/catkin_ws/src --ignore-src --rosdistro $ROS_DISTRO \
#    && /bin/bash -c '. /opt/ros/$ROS_DISTRO/setup.bash; cd ~/catkin_ws/; catkin_make'

RUN wstool init ~/catkin_ws/src panther.rosinstall \
    && apt-get update \
    && rosdep install -y --from-paths ~/catkin_ws/src/panther_hardware --ignore-src --rosdistro $ROS_DISTRO \
    && rosdep install -y --from-paths ~/catkin_ws/src/roboteq_control --ignore-src --rosdistro $ROS_DISTRO \
    && /bin/bash -c '. /opt/ros/$ROS_DISTRO/setup.bash; cd ~/catkin_ws/; catkin_make'

# make default folder the catkin_ws workspace
WORKDIR ~/catkin_ws/
