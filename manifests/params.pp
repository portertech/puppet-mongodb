# Class: mongodb::params
#
# This class manages MongoDB parameters
#
# Parameters:
# - The 10gen Ubuntu $repository to use
#
# Sample Usage:
#  include mongodb::params
#
class mongodb::params {
	case $operatingsystemrelease {
		"10.04": {
			$repository="deb http://downloads.mongodb.org/distros/ubuntu 10.4 10gen"
		}
		"10.10": {
			$repository="deb http://downloads.mongodb.org/distros/ubuntu 10.10 10gen"
		}
	}
}
