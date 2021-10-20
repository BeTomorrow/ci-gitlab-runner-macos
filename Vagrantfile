# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "BeTomorrow/macos-bigsur-intel"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder ".", "/Users/vagrant/vagrant", type: "nfs"
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "playbook.yml"
  end
end
