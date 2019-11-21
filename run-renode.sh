#!/bin/bash

renode_bin=renode
scripts_path="/home/jesse/DornerWorksProjects/RISC-V\ Summit\ 2019/Code/Repo-sel4test/tools/sel4Extra/renode_support"
resc_path="${scripts_path// /\ }"
echo "Scripts : ${scripts_path}"
echo "RescPath: ${resc_path}"
${renode_bin} "${resc_path}/sel4test.resc"
