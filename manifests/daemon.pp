# == Define: phabricator::daemon
#
class phabricator::daemon {
  include phabricator::install
  include phabricator::db

  file { ['/var/tmp/phd',
          '/var/tmp/phd/pid',
          '/var/tmp/phd/log']:
    ensure => directory,
    owner  => root,
    group  => root,
  }

  file { '/etc/init.d/phd':
    ensure  => present,
    mode    => '0755',
    content => template('phabricator/phd.erb'),
  }

  service { 'phd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/init.d/phd'],
  }
}