#
# Cookbook Name:: bach_repository
# Recipe:: ubuntu
#
include_recipe 'bach_repository::directory'
bins_dir = node['bach']['repository']['bins_directory']

remote_file "#{bins_dir}/ubuntu-14.04-hwe44-mini.iso" do
  source 'http://archive.ubuntu.com/ubuntu/dists/trusty-updates/main/' \
    'installer-amd64/20101020ubuntu318.41/images/xenial-netboot/mini.iso'
  mode 0444
  checksum '8e687af1db37966863a47f614a831ef540d11794a007831ea3875a155049018b'
end

