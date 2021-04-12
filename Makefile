# @Author: Nick Steele <nichlock>
# @Date:   20:00 Sep 18 2020
# @Last modified by:   nichlock
# @Last modified time: 19:09 Sep 19 2020

# Makefile for docker container with SSH server/X11 client

LOCAL_IMAGE_TAG = piranhabot:local
BASE_IMAGE_TAG = piranhabot:base-ros

CONTAINER_NAME = piranhabot_container

# Docker commands
D_RUN = docker run
D_BUILD = docker build
D_RM_IMAGE = docker image rm
D_KILL = docker kill

# Dockerfile Locations
LOCAL_DOCKERFILE = ./local.dockerfile
BASE_DOCKERFILE = ./base.dockerfile

refresh: check-is-submodule kill local

local: check-is-submodule build-local run-local

base: check-is-submodule build-base


# This makefile must be run from a Git submodule
check-is-submodule: | ../.git
	@ECHO "Running in a github submodule"

## BASE IMAGE #################################################################
# Buld the basic ROS image with GCC 8 and some other helpers.
build-base:
	$(D_BUILD) \
	-t $(BASE_IMAGE_TAG) \
	-f $(BASE_DOCKERFILE) \
	.

## LOCAL BUILDS ###############################################################
# These build off the source files found in ../
build-local: base
	$(D_BUILD) \
	-t $(LOCAL_IMAGE_TAG) \
	-f $(LOCAL_DOCKERFILE) \
	../

run-local: build-local
	@echo ctrl-P then ctrl-Q to detach.
	$(D_RUN) \
	-p 22:22 \
	--rm \
	--env DISPLAY=host.docker.internal:0 \
	--name $(CONTAINER_NAME) \
	-it $(LOCAL_IMAGE_TAG)

## KILL DETATCHED CONTAINER ###################################################
kill:
	-$(D_KILL) $(CONTAINER_NAME)
