#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory

# Windows Virtual Box has 260 character limit on the file path length; we need to run puppet from
# the non-mapped directory, or we'll hit this limit when librarin builds its cache.
PUPPET_SRC='/vagrant/provision/puppet'
PUPPET_DIR='/tmp/puppet'

rm -rf $PUPPET_DIR
cp -R $PUPPET_SRC $PUPPET_DIR

# NB: librarian-puppet might need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum
GIT=/usr/bin/git
APT_GET=/usr/bin/apt-get
YUM=/usr/sbin/yum
if [ ! -x $GIT ]; then
    if [ -x $YUM ]; then
        yum -q -y install git
    elif [ -x $APT_GET ]; then
        apt-get -q -y install git
    else
        echo "No package installer available. You may need to install git manually."
    fi
fi

apt-get update

if [ `gem query --local | grep librarian-puppet | wc -l` -eq 0 ]; then
  # @see https://github.com/rodjek/librarian-puppet/issues/70
  # librarian-puppet was replaced with librarian-puppet-maestrodev
  gem install librarian-puppet-maestrodev --no-ri --no-rdoc
  gem install puppet --no-ri --no-rdoc

  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi

# now we run puppet
puppet apply --modulepath=$PUPPET_DIR/modules/ $PUPPET_DIR/manifests/main.pp
