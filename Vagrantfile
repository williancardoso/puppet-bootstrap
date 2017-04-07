# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|

  ### PUPPET SERVER
  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppetserver"
    puppet.vm.network :private_network, ip: "192.168.10.10"
    puppet.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "1024" ]
      v.customize ["modifyvm", :id, "--cpus", "1" ]
    end
    puppet.vm.provision :shell, :path => "bootstrap.sh"
  end
end
