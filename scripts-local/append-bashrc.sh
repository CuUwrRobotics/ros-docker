# @Author: Nick Steele <nichlock>, Peter Lefp <lefp>
# @Date:   21:59 Sep 01 2020
# @Last modified by:   Nick Steele
# @Last modified time: 19:55 May 12 2021

echo Starting bashrc appends
# Colorize prompt and include container ID in it
echo "PS1='\[\033[0m\]\u@\[\033[1;32m\]\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\\$ '" >> /root/.bashrc
# Set LS_COLORS
cat $START_SCRIPTS/ls-colors-setup >> /root/.bashrc

# ROS setups
echo "source /opt/ros/$ROS_VERSION_NAME_SHORT/setup.sh" >> /root/.bashrc
echo "source $CATKIN_WS/devel/setup.sh" >> /root/.bashrc

echo Finished bashrc appends
