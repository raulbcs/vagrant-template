Exec {
  environment => "HOME=/home/vagrant",
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] 
}

class { 'stdlib':
}

class { 'apt':
  always_apt_update => true
}

apt::ppa { 'ppa:ondrej/php5-oldstable': }

import 'goodies.pp'
import 'php.pp'