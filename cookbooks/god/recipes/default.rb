gem_package "god" do
  action :install
end

directory "/etc/god" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

remote_file "/etc/god/config.rb" do
  owner "root"
  group "root"
  mode 0644
  source "config.rb"
end

execute "inittab-god" do
  command <<-SH
cat >> /etc/inittab <<EOS
# god config
god:345:respawn:/usr/bin/god -c /etc/god/resque.rb --log-level error -D
god0:06:wait:/usr/bin/god quit
EOS
  SH
  not_if { system("grep '# god config' /etc/inittab") }
end

execute "inittab-reload" do
  command "telinit q"
end
