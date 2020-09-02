# This will create a dockerfile and then copy the source files from the context
# directory.
# Requires that base.dockerfile is also built (use make base)
FROM pirhanabot:base-ros


## Copy From Host For Worksapce Setup #########################################
ENV HOME=/root
RUN mkdir ${HOME}/catkin_ws
RUN mkdir ${HOME}/catkin_ws/src
RUN mkdir ${HOME}/catkin_ws/src/temp
# Copy the packages
COPY . ${HOME}/catkin_ws/src/temp/

## Copy Scripts ###############################################################
COPY ./ros-docker/scripts-local/* /scripts/

## Startup ####################################################################
# At run, this will execute any command set up previously by echoing into it.
ENTRYPOINT ["/bin/bash"]
CMD ["/scripts/startup.sh"]
