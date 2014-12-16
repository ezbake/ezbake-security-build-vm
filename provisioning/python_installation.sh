#!/bin/bash

if [ -d rp_env_setup ];
then
    echo "reverse proxy environment setup directory already exists"
else
     mkdir rp_env_setup
fi

cd rp_env_setup

if [ -f /opt/python-2.7.6/bin/python ];
then
    echo "Python 2.7.6 appears to be installed in /opt, skipping Python build"
else
    if [ -f Python-2.7.6.tgz ];
    then
        echo "Python-2.7.6.tgz exists, skipping download";
    else
        wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz
    fi
    if [ -d Python-2.7.6 ];
    then
        rm -rf Python-2.7.6
    fi
    tar xzvf Python-2.7.6.tgz
    cd Python-2.7.6
    export LD_RUN_PATH=/opt/python-2.7.6/lib
    ./configure --prefix=/opt/python-2.7.6 --enable-shared
    make
    sudo make install
    cd ..
fi

export PATH=/opt/python-2.7.6/bin:$PATH

echo "PATH ----> "$PATH
echo "WHO AM I -----> "`who am i`

if [[ -n $(ls /opt/python-2.7.6/lib/python2.7/site-packages/setuptools*) ]]; then
    echo "Setuptools appears to be already installed, skipping"
else
    if [ -f setuptools-2.2.tar.gz ]; then
        echo "Setuptools already downloaded"
    else
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo env PATH=$PATH /opt/python-2.7.6/bin/python
        sudo env PATH=$PATH easy_install pip
        sudo env PATH=$PATH alternatives --install /usr/bin/pip-python pip-python `which pip` 1
    fi
fi


# I really wanted to put this in the reverseproxy_pip module and control it with puppet.
# But, the external issue messes things up. It seems like passing:
# "gevent_inotifyx --allow-external inotifyx --allow-unverified inotifyx"
# but the command doesn't succeed when run by puppet.
if [[ -n $(ls /opt/python-2.7.6/lib/python2.7/site-packages/gevent_inotifyx*) ]]; then
    echo "gevent inotifyx already installed"
else
    /usr/bin/pip-python install -q --upgrade gevent_inotifyx --allow-external inotifyx --allow-unverified inotifyx
fi


if [[ -n $(ls /opt/python-2.7.6/lib/python2.7/site-packages/netifaces*) ]]; then
    echo "netifaces already installed"
else
    /usr/bin/pip-python install -q --upgrade netifaces --allow-external netifaces --allow-unverified netifaces
fi


# set python to the one we just installed for the vagrant user
cd ..
if grep --quiet python .bashrc;
then
    echo "python 2.7 already in path"
else
    echo "export PATH=/opt/python-2.7.6/bin:\${PATH}" >> .bashrc
fi

