# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  config.vm.host_name = 'mongo'
  config.vm.share_folder "mongodb", "/tmp/vagrant-puppet/modules/mongodb", "."
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "tests"
    puppet.manifest_file = "vagrant.pp"
    puppet.options = ["--modulepath", "/tmp/vagrant-puppet/modules"]
  end
end
