echo Starting bashrc appends
# Colorize prompt and include container ID in it
echo "PS1='\[\033[0m\]\u@\[\033[1;32m\]\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\\$ '" >> /root/.bashrc
# Set LS_COLORS
cat $temporary_package_directory/ros-docker/scripts-local/LS_COLORS-setup >> /root/.bashrc

# ROS setups
echo "source /opt/ros/melodic/setup.sh" >> /root/.bashrc
echo "source $HOME/catkin_ws/devel/setup.sh" >> /root/.bashrc

echo Finished bashrc appends
