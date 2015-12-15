# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"

  config.vm.define :puppet do |puppet|
    config.vm.hostname = "puppet.sysops.lab"
    puppet.vm.box = 'puppetlabs/centos-6.6-64-nocm'
    puppet.vm.network :private_network, ip:'192.168.11.10'
    config.vm.provision "shell", path: "foreman.sh"
    config.vm.provider :virtualbox do |vb, override|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end

  config.vm.define :web do |web|
    config.vm.hostname = "web.sysops.lab"
    web.vm.box = 'puppetlabs/centos-7.0-64-nocm'
    config.vm.provision "shell", path: "bootstrap-puppet.sh"
    web.vm.network :private_network, ip:'192.168.11.20'
  end

  config.vm.define :db do |db|
    config.vm.hostname = "db.sysops.lab"  
    db.vm.box = 'puppetlabs/centos-7.0-64-nocm'
    config.vm.provision "shell", path: "bootstrap-puppet.sh"
    db.vm.network :private_network, ip:'192.168.11.30'
  end
end
