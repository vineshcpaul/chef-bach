#
# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# This is a Vagrantfile to provision blank Ubuntu images for use with
# chef-bach.
#
# See http://www.vagrantup.com/ for info on Vagrant.
#

require 'json'
require 'ipaddr'
prefix = File.basename(File.expand_path('.')) == 'vbox' ? '../' : './'
require_relative "#{prefix}lib/cluster_data"
require_relative "#{prefix}lib/hypervisor_node"

include BACH::ClusterData
include BACH::ClusterData::HypervisorNode

#
# You can override parts of the vagrant config by creating a
# 'Vagrantfile.local.rb'
#
# (You may find this useful for SSL certificate injection.)
#
local_file =
  if File.basename(File.expand_path('.')) == 'vbox'
    File.expand_path('../Vagrantfile.local.rb')
  else
    "#{__FILE__}.local.rb"
  end

if File.exist?(local_file)
  if ENV['BACH_DEBUG']
    $stderr.puts "Found #{local_file}, including"
  end
  require local_file
end

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-14.04'

  # These memory and CPU settings are used for all cluster nodes, and the bootstrap as well.
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.cpus = ENV.fetch 'CLUSTER_VM_CPUs', 2
    vb.memory = ENV.fetch 'CLUSTER_VM_MEM', 8192
    vb.linked_clone = true
  end

  config.vm.define 'bootstrap', primary: true do |bs|
    bs.vm.hostname = 'bootstrap.bcpc.example.com'

    # FIXME calculate subnets from Test-Laptop.json
    bs.vm.network :private_network, ip: '10.0.100.3', netmask: '255.255.255.0'

    bs.vm.synced_folder '.', '/home/vagrant/chef-bcpc', type: 'rsync',
        rsync__args: %w(--verbose --archive -z --partial --progress),
        rsync__exclude: %w(vendor Gemfile.lock .kitchen .chef)
    bs.vm.synced_folder '../cluster', '/home/vagrant/cluster', type: 'rsync'

    chefdk_version = ENV.fetch 'CHEFDK_VERSION', '1.2.22'
    omnibus_url = ENV.fetch 'OMNIBUS_URL', 'https://omnitruck.chef.io/install.sh'

    bs.vm.provision 'deploy-chefdk', type: 'shell', path: omnibus_url,
        args: ['-P', 'chefdk', '-v', chefdk_version], run: 'never'
    bs.vm.provision 'build-cookbooks', type: 'shell', run: 'never' do |s|
      s.privileged = false
      s.inline = <<~eos
        cd ~vagrant/chef-bcpc
        ./build_cookbooks.sh
      eos
    end
    bs.vm.provision 'deploy-cookbooks', type: 'shell', run: 'never' do |s|
      s.privileged = false
      s.args = ENV.fetch 'COOKBOOKS_URL', 'file:///home/vagrant/chef-bcpc/release_master_cookbooks.tar.gz'
      s.inline = <<~eos
        cd ~vagrant/chef-bcpc
        ./deploy_cookbooks.sh $@
      eos
    end
    bs.vm.provision 'deploy-bins', type: 'shell', run: 'never' do |s|
      s.args = ENV.fetch 'BINS_URL', 'file:///home/vagrant/chef-bcpc/release_master_bins.tar.gz'
      s.inline = <<~eos
        cd ~vagrant/chef-bcpc
        ./deploy_bins.sh $@
      eos
    end if ENV.has_key? 'BINS_URL'
    bs.vm.provision 'build-bins', type: 'shell', run: 'never' do |s|
      s.inline = <<~eos
        cd ~vagrant/chef-bcpc
        ./build_bins.sh
      eos
    end
  end

  #
  # Parse the cluster.txt selected by shell scripts (either Hadoop or
  # Kafka) and generate matching VMs.
  #
  parse_cluster_txt(cluster_txt).each do |vm_definition|
    config.vm.define vm_definition[:hostname] do |vboxvm|
      vboxvm.vm.hostname = vm_definition[:fqdn]
      vboxvm.vm.network :private_network,
                        ip: vm_definition[:ip_address],
                        netmask: '255.255.255.0'
      vboxvm.vm.provider :virtualbox do |vb|
        4.times do |i|
          port = i + 2 # ubuntu/trusty64 has port 0 for the root disk
          vb.customize ['createhd',
                        '--filename', ".vagrant/machines/#{vm_definition[:hostname]}/" \
                                      "#{vm_definition[:hostname]}-disk#{i}.vdi",
                        '--size', (40 * 1024)]

          # "SATA Controller" is the prebuilt controller in bento/ubuntu-14.04
          vb.customize ['storageattach', :id,
                        '--storagectl', 'SATA Controller',
                        '--port', port,
                        '--type', 'hdd',
                        '--medium', ".vagrant/machines/#{vm_definition[:hostname]}/" \
                                    "#{vm_definition[:hostname]}-disk#{i}.vdi"]
        end
      end
    end
  end
end
