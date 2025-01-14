#! bin/bash

# 监控定时工具12小时执行一次

CURRENT_DIR=$(cd "$(dirname "$0")" || exit; pwd) # 当前脚本所在目录
PARENT_DIR=$(dirname "$CURRENT_DIR") # 当前脚本所在目录的上级目录
# 公共入口
wURL=""
# Cn区
Cn_hosts="${wURL}/cn/hosts.list"
Cn_sources="${wURL}/cn/sources.list"
Cn_docker="${wURL}/cn/docker.list"

# En区
En_hosts="${wURL}/en/hosts.list"
En_sources="${wURL}/en/sources.list"
En_docker="${wURL}/en/docker.list"

CF_BESTIP="${CURRENT_DIR}/cfbestip_hosts.txt"
get_latest_CF_BESTIP() {

    CF_BESTIP=$(cat $CF_BESTIP)
    echo "$CF_BESTIP"
}

set_CF_BESTIP_hosts() {
    # 设置hosts
    local CF_BESTIP_HOSTS
    CF_BESTIP_HOSTS=$(get_latest_CF_BESTIP)
    if [ -z "$CF_BESTIP_HOSTS" ]; then
        echo "未能获取最新地址"
        exit 1
    fi
    sed -i '/# CF_BESTIP_HOSTS_Aspnmy/,/# CF_BESTIP_HOSTS_Aspnmy/d' ${PARENT_DIR}/hosts


    # 将远程数据写入hosts文件
    echo "# CF_BESTIP_HOSTS_Aspnmy" >> ${PARENT_DIR}/hosts
    echo "$CF_BESTIP_HOSTS" >> ${PARENT_DIR}/hosts
    echo "# CF_BESTIP_HOSTS_Aspnmy" >> ${PARENT_DIR}/hosts
}



main() {
    set_CF_BESTIP_hosts
}

main