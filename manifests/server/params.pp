# Defaults for mongodb::server. See README.md for details.

class mongodb::server::params {
  $repository = "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
  $package = "mongodb-10gen"
}
