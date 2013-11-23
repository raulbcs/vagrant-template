package { 'php5-cli':
  ensure => 'installed'
}

exec { 'composer install':
  command => 'curl -sS https://getcomposer.org/installer | php && mv composer.phar composer',
  cwd => '/usr/local/bin/',
  creates => '/usr/local/bin/composer'
}