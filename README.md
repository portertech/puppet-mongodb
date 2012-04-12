# MongoDB Module #

Module for creating a MongoDB server on an Ubuntu server, using 

    Author	: Sean Porter <portertech@gmail.com>
    Version	: 0.1.0
    Licence : Apache

## INSTALLATION ##

* Use a Ubuntu AMI provided by [Alestic]

* Manage `/etc/puppet` with [Git]

* Add `puppet-mongodb` as a submodule:

        cd /etc/puppet
        git submodule add git://github.com/portertech/puppet-mongodb.git modules/mongodb
        git submodule init
        git submodule update

* To update it:

        cd /etc/puppet
        git pull modules/mongodb

### Installation For Those Not Managing Puppet With Git ###

* Clone this module into `/etc/puppet/modules`:

        cd /etc/puppet/modules
        git clone git://github.com/portertech/puppet-mongodb.git mongodb

* To update it:

        cd /etc/puppet/modules/mongodb
        git pull

[Alestic]: http://alestic.com/
[Git]: http://git-scm.com/

## USAGE ##

### Installing MongoDB ###

Install MongoDB on your nodes using the parameterized class `mongodb`. To 
accept all the defaults:

        class { 'mongodb::server': }

You can supply the following arguments:

* `repository`: the full `/etc/apt/sources.list.d` line for the ATP repository 
  from which you want to pull the package.

* `package`: the name of the package to install.

### Configuring MongoDB ###

Either set your own `/etc/mongodb.conf` contents using Puppet, or use
`mongodb::conf`:

    class { 'mongodb::server': }

    class { 'mongodb::conf':
      ulimit_nofile => 20000,
      replSet      => "replSet1",
    }

You can supply the following arguments matching [MongoDB configuration
file][File Based Configuration] entries:

* `dbpath`
* `logpath`
* `logappend` 
* `bind_ip`
* `port`
* `journal`
* `replSet`

You can also specify:

* `ulimit_nofile`: the number of files MondoDB is permitted to open. This
  includes its database files and open sockets for connections. See 
  [Too Many Open Files] for details on how to calculate a suitable
  limit.

* `extra_config`: a string with extra configuration for `/etc/mondodb.conf`.
  Use this when you need to specify arguments not included above without 
  having to extend the module or hand-craft your entire configuration file.

[File Based Configuration]: http://www.mongodb.org/display/DOCS/File+Based+Configuration]
[Too Many Open Files]: http://www.mongodb.org/display/DOCS/Too+Many+Open+Files

#### Special Considerations

* `dbpath`: the directory will be created and its ownership set to 
  `mongodb::mongodb`, but the parent directory will *not* be created. 

* `logpath`: the file will be created and its ownership set to 
  `mongodb:mongodb`, but the directory will *not* be created. 

* `journal`: defaults to `true`, even on 32-bit platforms, and will be
  inverted and specified as `nojournal` to ensure it's followed on 
  platforms for which journalling is the default.

#### Creating Parent Directories

To create parent directories yourself, add another file to your manifest:

    class { 'mongodb::conf':
      logpath => '/var/log/mungo/mungo.log',
    }

    file { '/var/log/mungo':
      ensure => directory,
      group  => mongodb,
      owner  => mongodb,
    }

    File['/var/log/mungo'] -> Class['mongodb::conf']

Puppet 2.7 and later will automatically find and execute parent
directory definitions, removing the need for the last line.

## TESTING ##

### Smoke Testing

* `make test` or `make smoke` to perform a simple [smoke test]

### Vagrant

* Install [Vagrant]

* Get the `lucid32` box (safe even if you already have it):

        vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

* Launch the virtual machine:

        vagrant up

* Profit.

[Vagrant]: http://vagrantup.com/
[smoke test]: http://docs.puppetlabs.com/guides/tests_smoke.html

## CONTRIBUTORS ##
* [v1rtual](https://github.com/v1rtual): Knut Moller
* [nixon](https://github.com/nixon)
* [cyounkins](https://github.com/cyounkins): Craig Younkins
* [mattmcmanus](https://github.com/mattmcmanus): Matt McManus
* [garthk](https://github.com/garthk): Garth Kidd

## CHANGELOG ##
- v0.0.1 : Hello World.
- v0.0.2 : Require apt to update.
- v0.0.3 : Fixed apt update.
- v0.0.4 : Support for multiple Ubuntu releases. Added replica set support.
- v0.0.5 : Support for Ubuntu Maverick (10.10).
- v0.0.6 : Added "python-software-properties" for apt abstraction.
- v0.0.7 : Added support for Ubuntu Natty Narwhal (11.04).
- v0.0.8 : Support Ubuntu releases (>= 9.04) (Upstart). Use a class. Adjust ulimit.
- v0.0.9 : Fixed possible duplicate Package["python-software-properties"].
- v0.1.0 : Added Vagrantfile; CHANGED API to move configuration to
  `mongodb::conf``
