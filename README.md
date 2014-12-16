# EzSecurty Build VM

## Dependencies
* git
* maven installed and connected to artifactory
* vagrant
* virtualbox

## Clone this project
git clone git@github.com:ezbake/ezbake-security-build-vm.git


## Start the vagrant VM
vagrant up
vagrant ssh


## Build EzFrontend RPMS 

```bash
cd /vagrant/ezfrontend
./build.sh
```

rpms are output to ezfrontend/RPMS

* EzFrontend-<version>-<datetime>.x86_64.rpm  - this is the frontend
* EzFrontend-UI-<version>-<datetime>.x86_64.rpm  - this is a cheesy web UI for monitoring the frontend status
* EzFrontend-libs-<version>-<datetime>.x86_64.rpm  - this is the package holding all libraries needed by the frontend
* EzFrontend-user-ca-certs-1.3-<datetime>.x86_64.rpm  - this is an RPM containing the CA certs to validate users PKI certs. In a real system, the SAs need to install the necessary files with each frontend in /opt/ezfrontend/config/ssl/user_ca_files
* EzFrontend-user-facing-certs-1.3-<datetime>.x86_64.rpm  - this is an RPM containing the certificate and key nginx uses to represent itself to clients. In a real system, the SAs need to install the necessary files with each frontend in /opt/ezfrontend/config/ssl/server


