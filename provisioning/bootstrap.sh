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


git clone https://github.com/sstephenson/rbenv.git /opt/.rbenv
if grep --quiet "/opt/.rbenv/bin:/usr/local/bin:$PATH" /etc/profile.d/rbenv.sh;
then
    echo "rbenv.sh already configured"
else
    echo 'export PATH="/opt/.rbenv/bin:/usr/local/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
fi
git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build
/tmp/ruby-build/install.sh

sudo -u vagrant -i sh - <<'EOF'
rb=$(rbenv install -l | grep -E 1.9.3-p[[:digit:]] | tail -n 1)
rbenv install ${rb}
rbenv global ${rb}
gem install bundler
EOF
