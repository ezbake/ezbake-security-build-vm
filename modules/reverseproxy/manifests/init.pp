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

