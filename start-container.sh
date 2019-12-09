#!/bin/bash

DOCKER_PATH="./tools/DockerFiles"
pwddir="$(pwd)"
host_dir="${pwddir// /\\ }"

make -C ${DOCKER_PATH} user_camkes-riscv USER_IMG=user_img-$(shell whoami)-riscv HOST_DIR="${host_dir}"
