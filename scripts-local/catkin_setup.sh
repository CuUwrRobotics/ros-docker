# @Author: Nick Steele <nichlock>
# @Date:   21:59 Sep 01 2020
# @Last modified by:   nichlock
# @Last modified time: 19:10 Sep 19 2020

echo Starting catkin workspace setup

cd ~/
# mkdir catkin_ws
# mkdir catkin_ws/src
cd catkin_ws

echo Running catkin_make in workspace...
source /opt/ros/melodic/setup.sh
catkin_make clean >> /dev/null


# echo Copying into workspace...
# git clone --branch $GIT_BRANCH $WORKSPACE_GIT
# cp -r $WORKSPACE_GIT_NAME/board_interface src/board_interface
# cp -r $WORKSPACE_GIT_NAME/watchdog src/watchdog

# echo Cleaning workspace...
# catkin_make clean >> /dev/null

echo Finished catkin workspace setup
