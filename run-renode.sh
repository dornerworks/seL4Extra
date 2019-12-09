#!/bin/bash

renode_bin=renode
scripts_path="$(pwd)/tools/sel4Extra/renode_support"
resc_path="${scripts_path// /\\ }"
dtb_path="${resc_path}/hifive-renode.dtb"

echo "RESC Script: ${resc_path}"
if [ -f "${dtb_path}" ]; then
    echo " DTB Exsists"
else
    echo "Making DTB"
    $(cd ${resc_path} && ./create-dtb.sh || echo "DTB creation failed, exiting.. " && exit 1)
fi

${renode_bin} "${resc_path}/camkes.resc"
