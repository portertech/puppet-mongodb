class { 'mongodb::server': }

class { 'mongodb::conf':
  dbpath       => "/var/db/mongodb",
  logpath      => "/var/log/mongodb.log",
  logappend    => true,
  bind_ip      => "127.0.0.1",
  port         => 27017,
  extra_config => "shardsvr = true",
}
