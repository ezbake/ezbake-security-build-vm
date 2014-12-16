#!/bin/bash

CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MAIN_BRANCH="master"
EZNGINX_BRANCH="master"

#set abort on error
set -e

#clone repos
if [ ! -d eznginx-ezsecurity ]; then
    echo "cloning eznginx-ezsecurity"
    git clone git@github.com:ezbake/ezbake-frontend.git
    cd ezbake-frontend
    git checkout ${MAIN_BRANCH}
    echo "completed clone and branch for eznginx-ezsecurity"

    echo "cloning eznginx"
    git clone git@github.com.org:ezbake/nginx.git
    cd nginx
    git checkout ${EZNGINX_BRANCH}
    echo "completed clone and branch for eznginx"

    echo "going to $CUR_DIR"
    cd $CUR_DIR
fi

#run builds
echo -e "\nRunning ezfrontend builds ..."
cd ezbake-frontend
./build.sh "$1"
cd ${CUR_DIR}
echo -e "\nDone building ezfrontend"

#copy RPMs
echo -e "Moving RPMs"
rm -f EzFrontend-*
mv ezbake-frontend/EzFrontend-*rpm .

#
echo -e "DONE"

