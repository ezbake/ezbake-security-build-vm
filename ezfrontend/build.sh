#!/bin/bash
#   Copyright (C) 2013-2014 Computer Sciences Corporation
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


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

