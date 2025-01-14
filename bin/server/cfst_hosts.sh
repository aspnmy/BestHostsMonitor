#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

CURRENT_DIR=$(cd "$(dirname "$0")" || exit; pwd) # 当前脚本所在目录
PARENT_DIR=$(dirname "$CURRENT_DIR") # 当前脚本所在目录的上级目录
source ${CURRENT_DIR}/getbestHosts.sh


get_CloudflareBestIP() {
	# 这里可以自己添加、修改 CloudflareST 的运行参数
	./CloudflareST -o "result_hosts.txt" 

	BESTIP=$(sed -n "2,1p" result_hosts.txt | awk -F, '{print $1}')
	if [[ -z "${BESTIP}" ]]; then
		echo "CloudflareST 测速结果 IP 数量为 0，跳过下面步骤..."
		exit 0
	fi
	local cfhosts_files
	local myIPCountry
	myIPCountry=$(get_myIPCountry)
    if [ "$myIPCountry" = "中国" ]; then
   		cfhosts_files="cfhosts-cn.aspnmy"
        
    else
        cfhosts_files="cfhosts-en.aspnmy"
    fi

    # 删除 # CF_BESTIP_HOSTS_Aspnmy 到 # CF_BESTIP_HOSTS_Aspnmy 之间的数据包括标签本身
    sed -i '/# CF_BESTIP_HOSTS_Aspnmy/,/# CF_BESTIP_HOSTS_Aspnmy/d' ${CURRENT_DIR}/${cfhosts_files}
	time=$(date "+%Y-%m-%d %H:%M:%S")
	

    echo "# CF_BESTIP_HOSTS_Aspnmy" >> ${CURRENT_DIR}/${cfhosts_files}
	echo "${BESTIP} *.cloudflare.com" >> ${CURRENT_DIR}/${cfhosts_files}
	echo "# 更新时间：${time}" >> ${CURRENT_DIR}/${cfhosts_files}
    echo "# CF_BESTIP_HOSTS_Aspnmy" >> ${CURRENT_DIR}/${cfhosts_files}
}




main(){
    get_CloudflareBestIP
}

main