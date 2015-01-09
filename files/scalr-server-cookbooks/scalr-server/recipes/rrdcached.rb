[node[:scalr][:rrd][:rrd_dir], node[:scalr][:rrd][:img_dir], '/var/lib/rrdcached/journal'].each do |dir|
  directory dir do
    owner node[:scalr][:core][:users][:service]
    group node[:scalr][:core][:group]
    mode 0755
    recursive true
    notifies :restart, "service[rrdcached]", :delayed
  end
end

%w{x1x6 x2x7 x3x8 x4x9 x5x0}.each do |dir|
  directory "#{node[:scalr][:rrd][:rrd_dir]}/#{dir}" do
    owner node[:scalr][:core][:users][:service]
    group node[:scalr][:core][:group]
    mode 0755
    notifies :restart, "service[rrdcached]", :delayed
  end
end

package value_for_platform_family(['rhel', 'fedora'] => 'rrdtool', 'debian' => 'rrdcached')

template value_for_platform_family(
  ['rhel', 'fedora'] => '/etc/sysconfig/rrdcached',
  'debian' => '/etc/default/rrdcached'
) do
  source "#{node[:platform_family]}-rrdcached.erb"
  notifies :restart, "service[rrdcached]", :delayed
end

# On RHEL 7, we install rrdcached from the CentOS 7 repos,
# which don't have an init file for rrdcached
rrdcached_init = '/etc/init.d/rrdcached'
cookbook_file rrdcached_init do
  owner     'root'
  group     'root'
  mode      0755
  source    'rrdcached-init'
  not_if    "ls -- '#{rrdcached_init}'"
end

service 'rrdcached' do
  action [:enable, :start]
end
