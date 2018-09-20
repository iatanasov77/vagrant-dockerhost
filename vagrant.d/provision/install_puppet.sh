#!/bin/bash

echo "installing Puppet"
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
apt-get -y install puppet

echo "ensure puppet service is running"
puppet resource service puppet ensure=running enable=true

echo "ensure puppet service is running for standalone install"
puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'

apt-get -y install ruby-dev
gem install librarian-puppet
gem install curl

cd /vagrant/vagrant.d/puppet
librarian-puppet install --verbose
cd --
