# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  # Mysql
  config.vm.define "mysql" do |mysql|
    mysql.vm.hostname = "mysql.localdomain"
    mysql.vm.network :private_network, ip: "192.168.100.10"
    mysql.vm.provision "shell", path: "installer.sh"
    mysql.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "1" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
      v.customize [ "modifyvm", :id, "--name", "mysql.localdomain" ]
      v.customize [ "modifyvm", :id, "--groups", "/sei" ]
    end
  end

  # solr
  config.vm.define "solr" do |solr|
    solr.vm.hostname = "solr.localdomain"
    solr.vm.network :private_network, ip: "192.168.100.20"
    #solr.hostsupdater.aliases = ["puppetboard.hacklab", "puppetexplorer.hacklab"]
    solr.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "1" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
      v.customize [ "modifyvm", :id, "--name", "solr.localdomain" ]
      v.customize [ "modifyvm", :id, "--groups", "/sei" ]
    end
  end

  # jod
  config.vm.define "jod" do |jod|
    jod.vm.hostname = "jod.localdomain"
    jod.vm.network :private_network, ip: "192.168.100.30"
    #jod.hostsupdater.aliases = ["puppetboard.hacklab", "puppetexplorer.hacklab"]
    jod.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "1" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
      v.customize [ "modifyvm", :id, "--name", "jod.localdomain" ]
      v.customize [ "modifyvm", :id, "--groups", "/sei" ]
    end
  end

  # sei
  config.vm.define "sei" do |sei|
    puppetmq.vm.hostname = "sei.localdomain"
    puppetmq.vm.network :private_network, ip: "192.168.100.40"
    puppetmq.vm.provider "virtualbox" do |v|
      v.customize [ "modifyvm", :id, "--cpus", "1" ]
      v.customize [ "modifyvm", :id, "--memory", "1024" ]
      v.customize [ "modifyvm", :id, "--name", "sei.localdomain"]
      v.customize [ "modifyvm", :id, "--groups", "/sei" ]
    end
  end

end
