# Makefile for docker container with SSH server/X11 client

GIT_IMAGE_TAG = piranhabot:git
LOCAL_IMAGE_TAG = piranhabot:local
BASE_IMAGE_TAG = piranhabot:base-ros

CONTAINER_NAME = piranhabot_container

# Docker commands
D_RUN = docker run
D_BUILD = docker build
D_RM_IMAGE = docker image rm
D_KILL = docker kill

# Dockerfile Locations
GIT_DOCKERFILE = ./git.Dockerfile
LOCAL_DOCKERFILE = ./local.Dockerfile
BASE_DOCKERFILE = ./base.Dockerfile

refresh: check-is-submodule kill local

local: check-is-submodule build-local run-local

git: check-is-submodule build-git run-git

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

## GIT BUILDS #################################################################
# These build off the source files in the github branch in the Dockerfile
# Build the image using Dockerfile
build-git: base
	$(D_BUILD) \
	-t $(GIT_IMAGE_TAG) \
	-f $(GIT_DOCKERFILE) \
	.

# Pressing ^C will kill this container; use ^P then ^Q to detach.
run-git: build-git
	@echo ctrl-P then ctrl-Q to detach.
	$(D_RUN) \
	-p 22:22 \
	--rm \
	--env DISPLAY=host.docker.internal:0 \
	--name $(CONTAINER_NAME) \
	-it $(GIT_IMAGE_TAG)

## KILL DETATCHED CONTAINER ###################################################
kill:
	-$(D_KILL) $(CONTAINER_NAME)

## CLEANUPS ###################################################################

clean:
	$(D_RM_IMAGE) -f $(GIT_IMAGE_TAG)
	$(D_RM_IMAGE) -f $(GIT_IMAGE_TAG)

clean-base:
	$(D_RM_IMAGE) -f $(BASE_IMAGE_TAG)
