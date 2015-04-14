# encoding: utf-8

execute "apt-get update" do
  action :nothing
  command "apt-get update"
end

packages = %w{gcc make build-essential bash vim git curl libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev}
packages.each do |pkg|
  package pkg do
    options "-o Dpkg::Options::='--force-confold' -f --force-yes"
    action [:install, :upgrade]
    version node[:versions][pkg]
  end
end

service 'apache2' do
  action :stop
end

Execute "gem install sass" do
    not_if "which sass"
end

template "/home/vagrant/.npmrc" do
  owner "vagrant"
  group "vagrant"
  mode 0644
  source ".npmrc"
end
template "/home/vagrant/.bashrc" do
  owner "vagrant"
  group "vagrant"
  mode 0644
  source ".bashrc"
end
template "/home/vagrant/.bash_profile" do
  owner "vagrant"
  group "vagrant"
  mode 0644
  source ".bash_profile"
end

npm_global_pacages = %w{bower}
npm_global_pacages.each do |npm_pkg|
  nodejs_npm npm_pkg
end

execute 'npm global package install' do
  command "su vagrant -l -c 'npm i -g node-gyp grunt-cli yo gulp'"
end
