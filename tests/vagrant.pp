stage { pre: before => Stage[main] }

class apt_get_update {
  $sentinel = "/var/lib/apt/first-puppet-run"

  exec { "initial apt-get update":
    command => "/usr/bin/apt-get update && touch ${sentinel}",
    onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -cnewer ${sentinel})\"",
    timeout => 3600,
  }
}

# The mongodb module requires python-software-packages, which can't be found
# on the Vagrant lucid32 image unless you run apt-get update first.
class { 'apt_get_update':
  stage => pre,
}

# The Vagrant lucid32 image doesn't create the 'puppet' group, and can't 
# properly finish a run without it.
group { 'puppet':
  ensure => "present",
}

# Finally, we test our module:
class { 'mongodb':
  # replSet     => "set",
  ulimit_nofile => 20000,
}
