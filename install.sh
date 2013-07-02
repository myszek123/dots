#! /bin/bash
cd ~
wget http://apt.puppetlabs.com/puppetlabs-release-quantal.deb
dpkg -i puppetlabs-release-quantal.deb
sudo apt-get update
apt-get -y install puppet

sudo puppet module install puppetlabs/stdlib
sudo puppet module install puppetlabs/vcsrepo
