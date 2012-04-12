# Class: mongodb::conf
#
# This class manages the MongoDB configuration file. It's separate from
# the main mongodb class so that you can manage the configuration file
# yourself if required.
#
# Defaults are in mongodb::conf::params in params.pp.
#
# To specify configuration items not currently included in the params,
# specify `extra_config` with the lines you need.
#
# Sample Usage:
#  class mongodb::conf {
#    replSet      => "replset1",
#    extra_config => "mms-token = \"fnord\"",
#  }

class mongodb::conf(
  $dbpath          = $mongodb::conf::params::dbpath,
  $logpath         = $mongodb::conf::params::logpath,
  $logappend       = $mongodb::conf::params::logappend,
  $bind_ip         = $mongodb::conf::params::bind_ip,
  $port            = $mongodb::conf::params::port,
  $journal         = $mongodb::conf::params::journal,
  $replSet         = $mongodb::conf::params::replSet,
  $ulimit_nofile   = $mongodb::conf::params::ulimit_nofile,
  $extra_config    = $mongodb::conf::params::extra_config
) inherits mongodb::conf::params {
  case $journal {
    true: {
      $nojournal = false
    }
    false: {
      $nojournal = true
    }
    default: {
      fail("journal must be true or false, not ${journal}")
    }
  }

  file { "/etc/init/mongodb.conf":
    content => template("mongodb/etc-init-mongodb.conf.erb"),
    mode    => '0644',
    notify  => Service['mongodb'],
  }

  file { '/etc/mongodb.conf':
    content => template("mongodb/etc-mongodb.conf.erb"),
    mode    => '0644',
    notify  => Service['mongodb'],
  }

  file { $logpath:
    ensure => present,
    mode   => '0644',
    owner  => mongodb,
    group  => mongodb,
  }

  file { $dbpath:
    ensure => directory,
    mode   => '0755',
    owner  => mongodb,
    group  => mongodb,
  }

  Class['mongodb::conf'] -> Class['mongodb::server']
}
