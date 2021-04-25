# @Author: Nick Steele <nichlock>
# @Date:   20:00 Sep 18 2020

# This Dockerfile will create a basic ROS image which runs an SSH server and uses X11

## ROS Setup ##################################################################
# Start with base ROS image
FROM ros:noetic-ros-core-focal

# Install ros, because why would it be included in the ROS image? :/
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-core=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

## Run Installs ###############################################################
# These are run first to avoid having to re-run them on file edits/rebuilds
# Update apt
RUN apt-get update
# SSH server
RUN apt-get -y install openssh-server
# X11 server
RUN apt-get -y install x11-apps
# Text editor
RUN apt-get -y install nano
# Networking tools
RUN apt-get -y install net-tools iputils-ping
# GDB and a higher version of C++
RUN apt-get -y install gdb gcc-8 g++-8

## Copy From Host For Worksapce Setup #########################################
ENV HOME=/root
RUN mkdir ${HOME}/catkin_ws
RUN mkdir ${HOME}/catkin_ws/src
RUN mkdir ${HOME}/catkin_ws/temp
# These are for use when copying the correct temp files into the src folder.
ENV temporary_package_directory ${HOME}/catkin_ws/temp
ENV final_package_directory ${HOME}/catkin_ws/src
# Copy the packages
COPY . ${temporary_package_directory}

## Copy Scripts ###############################################################
COPY ./ros-docker/scripts-local/* /scripts/

## Startup ####################################################################
# At run, this will execute any command set up previously by echoing into it.
ENTRYPOINT ["/bin/bash"]
CMD ["/scripts/startup.sh"]
