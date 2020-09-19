# @Author: Nick Steele <nichlock>
# @Date:   20:00 Sep 18 2020

FROM piranhabot:base-ros


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
