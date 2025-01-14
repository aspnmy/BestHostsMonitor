#!/bin/bash

# 内存不足的时候可以停止所有进程

CURRENT_DIR=$(cd "$(dirname "$0")" || exit; pwd) # 当前脚本所在目录


main(){
   sudo pkill -f ${CURRENT_DIR}/cfst_hosts.sh
   sudo pkill -f ${CURRENT_DIR}/ck_bestIP_12htask.sh   
   sudo pkill -f ${CURRENT_DIR}/ck_bestHost_24htask.sh
   sudo pkill -f ${CURRENT_DIR}/down_CNip.sh
}

main