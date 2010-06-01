#
# Cookbook Name:: integrity
# Recipe:: default
#

package "sys-apps/miscfiles" do
  action :install
end

gem_package "bundler" do
  action :install
  version "0.9.25"
end

gem_package "rack" do
  action :install
  version "1.1.0"
end

directory "/tmp/integrity-builds" do
  action :create
  owner node[:owner_name]
  group node[:owner_name]
end

cron "clean-up old builds checkouts" do
  rack_env = node[:environment][:framework_env]
  hour "0"
  command "cd /data/ey_integrity/current && rake cleanup RACK_ENV=#{rack_env}"
end
