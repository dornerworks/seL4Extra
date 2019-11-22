#!/bin/bash

renode_bin=renode
scripts_path="$(pwd)/tools/sel4Extra/renode_support"
resc_path="${scripts_path// /\\ }"

echo "RescPath: ${resc_path}"
${renode_bin} "${resc_path}/sel4test.resc"
