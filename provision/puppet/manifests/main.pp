Exec {
  environment => "HOME=/home/vagrant"
}

class { 'stdlib':
}

class { 'apt':
  always_apt_update => true
}

package { 'vim':
  ensure => 'insalled'
}
