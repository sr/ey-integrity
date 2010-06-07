script "rvm bootstrap" do
  interpreter "bash"
  action :run
  user node[:owner_name]
  not_if { File.directory?("/home/#{node[:owner_name]}/.rvm") }
  code <<SH
export HOME=/home/#{node[:owner_name]}
cd $HOME/.rvm/src && git clone --depth 1 git://github.com/wayneeseguin/rvm.git && cd rvm && ./install
SH
end

%w[1.8.6 1.8.7 ree 1.9.1 jruby rbx].each { |ruby|
  script "rvm install #{ruby}" do
    interpreter "bash"
    action :run
    user node[:owner_name]
    code <<-SH
      source $HOME/.rvm/scripts/rvm
      [[ $(rvm list strings | grep #{ruby}) ]] && exit 0
      rvm install #{ruby}
    SH
  end
}
