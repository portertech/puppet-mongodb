# Class: mongodb::params
#
# This class manages MongoDB parameters
#
# Parameters:
# - The 10gen Ubuntu $repository to use
# - The 10gen Ubuntu $package to use
#
# Sample Usage:
#  include mongodb::params
#
class mongodb::params {
	case $operatingsystemrelease {
		"10.04": {
                        $repository="deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
			$package="mongodb-10gen"
		}
		"10.10": {
                        $repository="deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
			$package="mongodb-10gen"
		}
		"11.04": {
                  $repository="deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
		  $package="mongodb-10gen"
		}
                "11.10": {
                  $repository="deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
                  $package="mongodb-10gen"
                }
	}
}
