# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
    {
        :name => "redisbuilder",
        :eth1 => "192.168.38.100",
        :mem => "512",
        :cpu => "2",
    }
]

Vagrant.configure(2) do |cfg|
    cfg.vm.box = "centos/7"
    cfg.ssh.forward_agent = true
    cfg.vm.synced_folder ".", "/vagrant"

    boxes.each do |opts|
      cfg.vm.define opts[:name] do |config|
        config.vm.hostname = opts[:name]
        config.vm.network :private_network, ip: opts[:eth1]

        config.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--memory", opts[:mem]]
          v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
        end

        config.vm.provision "shell",
          inline: "/bin/sh /vagrant/provision_pre.sh"

        config.vm.provision "shell",
          inline: "/bin/sh /vagrant/provision_post.sh",
          privileged: false
      end
    end
end
