#!/bin/bash

DOCKER_PATH="./tools/DockerFiles"

make -C ${DOCKER_PATH} user_sel4-riscv USER_IMG=user_img-$(shell whoami)-riscv HOST_DIR=$(pwd)
