#!/bin/bash

echo "Cleaning up Yum repo"
sudo yum clean all

echo "Installing Puppet Repo"
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

echo "Installing EPEL repo"
sudo yum -y install epel-release http://yum.theforeman.org/releases/1.9/el7/x86_64/foreman-release.rpm

sudo yum -y install foreman-installer

echo "Running foreman-installer"
sudo foreman-installer --foreman-admin-password foreman


# Set-up firewall
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=69/tcp
sudo firewall-cmd --permanent --add-port=67-69/udp
sudo firewall-cmd --permanent --add-port=53/tcp
sudo firewall-cmd --permanent --add-port=53/udp
sudo firewall-cmd --permanent --add-port=8443/tcp
sudo firewall-cmd --permanent --add-port=8140/tcp

# Set-up firewall
#sudo iptables -f  ;
#sudo service iptables stop ; 
#sudo chkconfig iptables off

sudo firewall-cmd --reload
sudo systemctl enable firewalld

# First run the Puppet agent on the Foreman host which will send the first Puppet report to Foreman,
# automatically creating the host in Foreman's database
sudo puppet agent --test --waitforcert=60

# Optional, install some optional puppet modules on Foreman server to get started...
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-ntp
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-git
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-vcsrepo
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-haproxy
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-apache
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-java
sudo puppet module install -i /etc/puppet/environments/production/modules puppetlabs-mysql
sudo puppet module install -i /etc/puppet/environments/production/modules garethr-docker
sudo puppet module install -i /etc/puppet/environments/production/modules jfryman-nginx

