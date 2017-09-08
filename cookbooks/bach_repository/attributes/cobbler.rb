default['cobbler']['source']['build_user'] = 'vagrant'
default['cobbler']['source']['build_group'] = 'vagrant'
default['cobbler']['source']['dir'] = "#{node['bach']['repository']['src_directory']}/cobbler_build"
default['cobbler']['bin_dir'] = node['bach']['repository']['bins_directory']
