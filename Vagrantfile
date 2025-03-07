Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"
  config.vm.hostname = "dftd"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.name = "dftd"
     vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
     vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "../ansible/site.yml"
    ansible.compatibility_mode = "2.0"
  end
end
