#! /bin/sh
sudo puppet apply --modulepath `pwd`/modules:/etc/puppet/modules:/usr/share/puppet/modules `pwd`/install.pp
