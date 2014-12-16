# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos65"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.vm.synced_folder "~/.m2", "/home/vagrant/.m2"
  config.vm.synced_folder "~/.pip", "/home/vagrant/.pip"
  config.vm.synced_folder "~/.pip", "/root/.pip"

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "base.pp"
    puppet.module_path = "modules"
  end

  config.vm.provision :shell do |shell|
      shell.inline = "touch $1 && chmod 0440 $1 && echo $2 > $1"
      shell.args = %q{/etc/sudoers.d/root_ssh_agent "Defaults    env_keep += \"SSH_AUTH_SOCK\""}
  end

  config.vm.provision :shell, :path => "provisioning/bootstrap.sh"
  config.vm.provision :shell, :path => "provisioning/python_installation.sh"
  config.vm.provision :shell, :path => "provisioning/thrift_installation.sh"
  config.vm.provision :shell, :path => "provisioning/autoconf_installation.sh"
  config.vm.provision :shell, :path => "provisioning/boost_library_patch.sh"
  config.vm.provision :shell, :path => "provisioning/npm_installation.sh"
  config.vm.provision :shell, :path => "provisioning/addusers.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "site.pp"
    puppet.module_path = "modules"
  end

  config.vm.provision :shell, :path => "provisioning/zope_fix.sh"

end
