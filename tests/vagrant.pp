stage { pre: before => Stage[main] }

class apt_get_update {
  $sentinel = "/var/lib/apt/first-puppet-run"

  exec { "initial apt-get update":
    command => "/usr/bin/apt-get update && touch ${sentinel}",
    onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -cnewer ${sentinel})\"",
    timeout => 3600,
  }
}

# Run apt-get update prior to testing
class { 'apt_get_update':
  stage => pre,
}

# Ensure the Vagrant image has a 'puppet' user group for testing
group { 'puppet':
  ensure => "present",
}

# Finally, we test our module
class { 'mongodb':
  # replSet     => "set",
  ulimit_nofile => 20000,
}
