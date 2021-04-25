# @Author: Nick Steele <nichlock>
# @Date:   20:00 Sep 18 2020
# @Last modified by:   Nick Steele
# @Last modified time: 22:03 Apr 24 2021

# THIS MAKEFILE MUST BE RUN WITH THE CODE IN THE PARENT DIRECTORY
# THIS MAKEFILE MUST BE RUN WITH THE CODE IN THE PARENT DIRECTORY

# Makefile for docker container with SSH server/X11 client

IMAGE_TAG = piranhabot:ros

CONTAINER_NAME = piranhabot_container

# Dockerfile Location relative to Makefile
DOCKERFILE = ./Dockerfile

D_RUN = docker run
D_BUILD = docker build
D_RM_IMAGE = docker image rm
D_KILL = docker kill


refresh: check-is-submodule kill build-image run-container


# This makefile must be run with the code in the parent directory
check-is-submodule: | ../.git
	@ECHO "Running in a github submodule"

## LOCAL BUILDS ###############################################################
# These build off the local source files found in ../
build-image:
	$(D_BUILD) \
	-t $(IMAGE_TAG) \
	-f $(DOCKERFILE) \
	../

run-container: build-image
	@echo ctrl-P then ctrl-Q to detach.
	$(D_RUN) \
	-p 22:22 \
	-p 3000:3000 \
	--rm \
	--env DISPLAY=host.docker.internal:0 \
	--name $(CONTAINER_NAME) \
	-it $(IMAGE_TAG)

## KILL DETATCHED CONTAINER ###################################################
kill:
	-$(D_KILL) $(CONTAINER_NAME)
