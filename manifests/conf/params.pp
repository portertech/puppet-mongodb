# Defaults for mongodb::conf. See README.md for details.

class mongodb::conf::params {
  # enough room for nohttpinterface
  # arguments matching mongodb configuration file entries:
  $dbpath          = "/var/lib/mongodb"
  $logpath         = "/var/log/mongodb/mongodb.log"
  $logappend       = true
  $bind_ip         = "0.0.0.0"
  $port            = 27017
  $journal         = true
  $replSet         = ""
  
  # other arguments:
  $ulimit_nofile   = 1024
  $extra_config    = ""
}
