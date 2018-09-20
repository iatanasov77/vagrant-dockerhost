# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION	= '2'
VAGRANT_BOX			= 'ubuntu/bionic64'
HOSTNAME			= 'mydockerhost.lh'
MASHINE_NAME			= 'MyDockerHost'
MACHINE_CPUS			= '2'
MACHINE_MEMORY			= '2024'
PUBLIC_IP			= '10.2.2.2'
FOLDER_PROJECTS			= '../Dockerhost_Projects'

Vagrant.configure( VAGRANTFILE_API_VERSION ) do |vagrant_config|

	vagrant_config.vm.define MASHINE_NAME do |config|

	  	config.vm.box			= VAGRANT_BOX
	  	#config.vm.box_version
		config.vm.box_check_update	= true
		config.ssh.insert_key		= false		# insecure vagrant key

		config.vm.synced_folder FOLDER_PROJECTS, "/projects"

		config.vm.hostname 		= HOSTNAME
		config.vm.network :private_network, ip: PUBLIC_IP

		# Virtual Box Configuration
		config.vm.provider :virtualbox do |vb, override|
			vb.gui		= false
			vb.name		= MASHINE_NAME
			vb.memory	= MACHINE_MEMORY
			vb.cpus		= MACHINE_CPUS
		end
		
		##############################################################################
		# Mashine Provisioning
		##############################################################################
		config.vm.provision "shell", path: "vagrant.d/provision/install_puppet.sh"
		
	    	config.vm.provision :puppet do |puppet|
			puppet.manifests_path = 'vagrant.d/puppet/manifests'
			puppet.module_path    = 'vagrant.d/puppet/modules'
			#puppet.options        = ['--verbose', '--debug']

			puppet.manifest_file  = "default.pp"
		end
		
		config.vm.provision "shell", inline: <<-SHELL
			sudo usermod -aG docker vagrant
		SHELL
	end
	
end
