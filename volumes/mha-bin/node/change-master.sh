#!/bin/bash
# usage: 在从库上执行, 自动执行CHANGE MASTER使其形成主从链路
# author: prontera@github

#set -x
set -eo pipefail
shopt -s nullglob

check_args_empty(){
    if [[ "$#" == 0 ]]; then
        echo >&2 "$HOSTNAME option can not be an empty list when processing change master!"
		exit 1
    fi
}
check_args_empty "$@"

if [[ -z "$MYSQL_ROOT_PASSWORD" ]]; then
    echo "$HOSTNAME please set the environment variable MYSQL_ROOT_PASSWORD first!"
    exit 1
fi
mysql=( mysql -p"$MYSQL_ROOT_PASSWORD" )

for i in {30..0}; do
	if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
		break
	fi
	echo "$HOSTNAME MySQL init process in progress..."
	sleep 2
done
if [ "$i" = 0 ]; then
	echo >&2 "$HOSTNAME MySQL init process failed."
	exit 1
fi

change_master(){
	for ip do
	echo $ip
	"${mysql[@]}" <<-EOSQL
		STOP SLAVE;
		CHANGE MASTER TO MASTER_HOST="${ip}", MASTER_USER="${MYSQL_REPL_NAME}", MASTER_PASSWORD="${MYSQL_REPL_PASSWORD:-}", MASTER_AUTO_POSITION=1;
		START SLAVE;
	EOSQL
	done
}

change_master "$@"
exit 0
