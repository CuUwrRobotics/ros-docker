<!--
@Author: Nick Steele <nichlock>
@Date:   17:59 Sep 17 2020
@Last modified by:   nichlock
@Last modified time: 19:08 Sep 19 2020
-->

# ROS Noetic Docker Image
The docker image we use for testing our code when not working on the Raspberry Pi. It gives a common way of building and running the code we work on. This will give us all the same virtual OS to work on, and it will have that OS work on the same files as the ones in the repository this is added to.

# Using this as a submodule

To add this to a repository:
- Run `git submodule add https://github.com/CuUwrRobotics/ros-docker.git` in your repository
- Add the following lines to the `.gitignore` file in your repository:
  ```git-config
  # Ignore catkin build outputs
  .catkin_workspace
  devel/*
  build/*
  ```
- Create a `file-setup.sh` file in your root directory. (Make sure it has only newlines, no carriage returns.) This should handle any file setups that your code needs, for example copying images to an `/images` directory. You can create the file and leave it blank, but it needs to exist. Note that all your copied files can be found in the environment variable `$CATKIN_WS`. `file-setup.sh` Will be run while creating the container.

To use this in a repository:
- Run `make` in the directory that got added to your root folder.
- Once you see the green message indicating that it was successful, detach (with ctrl+P then ctrl+Q).
- After detatching, run `docker exec -it piranhabot_container /bin/bash` to enter into the container.
- Do anything you'd like from here; if you modify code you don't have to rebuild the container, since it will automatically update in the container.

**Once this is installed into your repository, don't edit it!** If you'd like to make a change you can edit and push it under a separate branch, but this is supposed to be consistent under all our repositories. Also, any changes need to be applied manually to each repository this is added to, so we want to be sure the change is worth it.

# Updates

To update this submodule, run the included file `update-submodules.sh` from the main directory (type `./ros-docker/update-submodules.sh` in your console).
