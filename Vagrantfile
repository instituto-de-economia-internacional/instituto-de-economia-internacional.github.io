# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.define "middleman" do |md|
      md.vm.hostname        = "middleman"
      md.vm.network         "private_network", ip: "192.168.33.10"
      md.ssh.forward_agent  = true
      md.vm.network         :forwarded_port, guest: 4567, host: 4567
    end
   config.vm.provision "ansible" do |ansible|
     ansible.playbook           = "ansible/middleman.yml"
     ansible.verbose            = "v"
     ansible.host_key_checking  = false
     ansible.inventory_path     = "ansible/inventory"
   end
end
