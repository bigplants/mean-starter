# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = %w( vagrant-omnibus vagrant-cachier )
required_plugins.each do |plugin|
	unless Vagrant.has_plugin? plugin
		required_plugins.each do |plugin|
			system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
		end

		puts "Please rerun `vagrant up`or`vagrant reload`."
		exit
	end
end

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty32"

	config.vm.network "private_network", ip: "192.168.50.111"

	config.vm.provider "virtualbox" do |v|
	  v.memory = 2048
	  v.cpus = 2
	end

	config.cache.scope = :box
	config.omnibus.chef_version = '11.4.4'

	doc_root = '/vagrant_data/'
	app_root = '/vagrant_data/'

	config.vm.synced_folder './', "/vagrant_data", :create => true, :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775,fmode=775']
	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = "cookbooks"
		chef.add_recipe "apt"
		chef.add_recipe "mongodb::10gen_repo"
		chef.add_recipe "mongodb::default"
		chef.add_recipe "nodejs"
		chef.add_recipe "mean"
		chef.json = {
			doc_root: doc_root,
			app_root: app_root,
			'nodejs'=>{
				'version'=>'0.12.2',
				'install_method'=>'binary'
			}
		}
	end

end
