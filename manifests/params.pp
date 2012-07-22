# Class: mongodb::params
#
# This class manages MongoDB parameters
#
# Parameters:
# - The 10gen Ubuntu $repository to use
# - The 10gen Ubuntu $package to use
# - Replica set to join
# - Whether to restart after crashing
# - Open files limit
#
# Sample Usage:
#  include mongodb::params
#
class mongodb::params {
  $repository = "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
  $package = "mongodb-10gen"

  # Replica set to join
  $replSet = ""

  # Whether to restart after crashing
  $respawn = ""

  # Number of open files ulimit can be changed if mongodb.log reports
  # "too many open files" or "too many open connections" messages.
  # MongoDB has an upper hard limit of 20k.
  # http://www.mongodb.org/display/DOCS/Too+Many+Open+Files
  $ulimit_nofile = 1024
}
