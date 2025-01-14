#!/bin/bash


CURRENT_DIR=$(cd "$(dirname "$0")" || exit; pwd) # 当前脚本所在目录
PARENT_DIR=$(dirname "$CURRENT_DIR") # 当前脚本所在目录的上级目录


ck_ONCE_CFIP(){
    bash ${CURRENT_DIR}/getbestHosts.sh > /dev/null 2>&1
}


main(){
    
    while true; do
    ck_ONCE_CFIP 
    #sleep 43200  # 43200 秒 = 12 小时
    sleep 86400
    done
}

main &