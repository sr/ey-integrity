execute "rvm bootstrap" do
  user node[:owner_name]
  not_if { File.directory?("/home/#{node[:owner_name]}/.rvm") }
  command "git clone --depth 1 git://github.com/wayneeseguin/rvm.git" \
    " && cd rvm && ./install"
end

node[:rvm][:rubies].each { |ruby|
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
