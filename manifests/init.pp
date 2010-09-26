# Class: mongodb
#
# This class installs MongoDB (stable)
#
# Notes:
#  This class is Ubuntu 10.04 specific for now.
#  By Sean Porter, Gastown Labs Inc.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include mongodb
#
class mongodb {
	exec { "10gen-apt-repo":
		path => "/bin:/usr/bin",
		command => "add-apt-repository 'deb http://downloads.mongodb.org/distros/ubuntu 10.4 10gen'",
		unless => "cat /etc/apt/sources.list | grep 10gen",
	}
	
	exec { "10gen-apt-key":
		path => "/bin:/usr/bin",
		command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
		unless => "apt-key list | grep 10gen",
		require => Exec["10gen-apt-repo"],
	}
	
	exec { "update-apt":
		path => "/bin:/usr/bin",
		command => "apt-get update",
		unless => "mongo --version 2> /dev/null",
		require => Exec["10gen-apt-key"],
	}

	package { "mongodb-stable":
		ensure => installed,
		require => Exec["update-apt"],
	}
	
	service { "mongodb":
		enable => true,
		ensure => running,
		require => Package["mongodb-stable"],
	}
}
