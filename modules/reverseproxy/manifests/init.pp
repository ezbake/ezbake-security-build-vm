/*   Copyright (C) 2013-2014 Computer Sciences Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. */

class reverseproxy {
  $build_yum = [ "wget" , "python-devel", "boost", "boost-devel", "libevent", "libevent-devel", "pcre", "pcre-devel", "zlib-devel", "openssl-devel", "readline-devel", "mlocate", "vim-enhanced", "tree", "libedit", "libtool", "byacc", "flex", "apr", "apr-devel", "apr-util", "apr-util-devel", ]

  $build_pip = [ "gevent", "greenlet", "kazoo", "pyaml", "pyinstaller", "web.py", "zbase32", "zbase62", "zope.interface", "jprops", "pycrypto", "gevent-websocket","gevent-socketio", "netifaces", "pyaccumulo"]

  package { $build_yum:
    ensure => latest,
    provider => yum
  }

  package { $build_pip:
    ensure => latest,
    provider => pip
  }

  package { "pyopenssl":
    ensure => "0.13.1",
    provider => pip
  }

  file { "/usr/lib64/libboost_thread.so":
    ensure => link,
    target => "/usr/lib64/libboost_thread-mt.so",
    require => Package["boost", "boost-devel"]
  }
}

