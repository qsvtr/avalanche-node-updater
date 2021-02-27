#!/bin/bash

AVALANCHE_SERVICE="avalanchenode"

NC='\033[0m'
GREEN='\e[0;32m'
RED='\033[0;31m'

echo "                    _                  _               _   _           _            _    _           _       _            ";
echo "     /\            | |                | |             | \ | |         | |          | |  | |         | |     | |           ";
echo "    /  \__   ____ _| | __ _ _ __   ___| |__   ___     |  \| | ___   __| | ___      | |  | |_ __   __| | __ _| |_ ___ _ __ ";
echo "   / /\ \ \ / / _\` | |/ _\` | '_ \ / __| '_ \ / _ \    | . \` |/ _ \ / _\` |/ _ \     | |  | | '_ \ / _\` |/ _\` | __/ _ \ '__|";
echo "  / ____ \ V / (_| | | (_| | | | | (__| | | |  __/    | |\  | (_) | (_| |  __/     | |__| | |_) | (_| | (_| | ||  __/ |   ";
echo " /_/    \_\_/ \__,_|_|\__,_|_| |_|\___|_| |_|\___|    |_| \_|\___/ \__,_|\___|      \____/| .__/ \__,_|\__,_|\__\___|_|   ";
echo "                                                                                          | |                             ";
echo "                   https://github.com/qsvtr/avalanche-node-updater                        |_|                             ";
echo -e "\n"


if ! sudo id > /dev/null
then
	echo -ne "${RED}Need to be start with root priviliges\n"
	exit
fi


echo -ne "stoping node............."
if sudo systemctl stop $AVALANCHE_SERVICE > /dev/null 2>&1
then
	echo -ne "${GREEN}OK!${NC}\n"
else
	echo -ne "${RED}KO!${NC}\n"
	exit
fi


echo -ne "updating Github repo....."
if cd $GOPATH/src/github.com/ava-labs/avalanchego > /dev/null 2>&1
then
	if git pull > /dev/null 2>&1
        then
                echo -ne "${GREEN}OK!${NC}\n"
        else
                echo -ne "${RED}KO!${NC}\n"
                exit
        fi
else
	echo -ne "${RED}KO!${NC}\n"
fi


echo -ne "building binary.........."
if ./scripts/build.sh > /dev/null 2>&1
then
	echo -ne "${GREEN}OK!${NC}\n"
else
        echo -ne "${RED}KO!${NC}\n"
        exit
fi

echo -ne "starting node............"
if sudo systemctl start $AVALANCHE_SERVICE > /dev/null 2>&1
then
	sleep 10 # need time before api request
	if [ -n "$(sudo systemctl status $AVALANCHE_SERVICE | grep active)" ]
	then
		echo -ne "${GREEN}OK!${NC}\n"
	else
		echo -ne "${RED}KO!${NC}\n*error message*\n"
	fi
else
        echo -ne "${RED}KO!${NC}\n*error message*\n"
        exit
fi

version=$(curl -sX POST --data '{"jsonrpc":"2.0","id":1,"method" :"info.getNodeVersion"}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info | jq -r '.result.version' | awk -F '/' '{print $2}' 2> /dev/null)
if [ ! -z "$version" ]
then
	echo -ne "\ndone! Node updated to version $version \n"
else
	echo -ne "fatal error\n"
fi
