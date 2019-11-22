#!/bin/bash

renode_install_dir="/opt/renode"
scripts_path="$(pwd)/tools/sel4Extra/renode_support"
resc_path="${scripts_path// /\\ }"
${renode_install_dir}/tests/test.sh \
                     --variable SCRIPT:"${resc_path}/sel4test.resc" \
                     tools/sel4Extra/renode_support/sel4test.robot
