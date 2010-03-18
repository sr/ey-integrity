require_recipe "god"

template "/etc/god/resque.rb" do
  owner "root"
  group "root"
  mode 0644
  source "resque.rb.erb"
end
