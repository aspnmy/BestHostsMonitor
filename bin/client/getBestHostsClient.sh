#! bin/bash

# 监控定时工具12小时执行一次

CURRENT_DIR=$(cd "$(dirname "$0")" || exit; pwd) # 当前脚本所在目录
PARENT_DIR=$(dirname "$CURRENT_DIR") # 当前脚本所在目录的上级目录
# 公共入口
wURL=""
# # Cn区
# Cn_hosts="${wURL}/CN/hosts.list"
# Cn_sources="${wURL}/CN/sources.list"
# Cn_docker="${wURL}/CN/docker.list"

# # En区
# En_hosts="${wURL}/EN/hosts.list"
# En_sources="${wURL}/EN/sources.list"
# En_docker="${wURL}/EN/docker.list"

CF_BESTIP="${CURRENT_DIR}/cfbestip_hosts.txt"
get_latest_CF_BESTIP() {

    CF_BESTIP=$(cat $CF_BESTIP)
    echo "$CF_BESTIP"
}

get_myIPCountry(){
# 国内接口获取ip
# 发送请求并提取 IP 地址
local truecountry
truecountry=$(curl -s  https://qifu-api.baidubce.com/ip/local/geo/v1/district | jq -r '.data.country')
    if [ -z "$truecountry" ]; then
        echo "未知地区。"
    else
        #echo "外网 IP 地址: $external_ip"
        echo "$truecountry"
    fi

}

ck_Country(){
	local myIPCountry
	myIPCountry=$(get_myIPCountry)
    if [ "$myIPCountry" = "中国" ]; then
    hosts="${wURL}/CN/hosts.list"
    sources="${wURL}/CN/sources.list"
    Cn_docker="${wURL}/CN/docker.list"
        
    else
        cfhosts_files="cfhosts-en.aspnmy"
    fi

}


main() {
    set_CF_BESTIP_hosts
}

main