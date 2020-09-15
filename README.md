# ros-docker
The docker images we use for testing our system

To use this in a repository, write the command `git submodule add https://github.com/CuUwrRobotics/ros-docker.git`. Run `make` in the directory that got added to build the container, then detatch (^P then ^Q). `docker exec -it [container_name] bash` will then enter into the container. `[container_name]` is defined by the makefile ([link](Makefile#L7)), so check that for the actual name!

To update, run the included file `update-submodules.sh` from the main directory (type `./ros-docker/update-submodules.sh` in your console).
