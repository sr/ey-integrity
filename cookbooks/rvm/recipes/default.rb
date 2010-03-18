script "rvm bootstrap" do
  interpreter "bash"
  action :run
  user node[:owner_name]
  not_if { File.directory?("/home/#{node[:owner_name]}/.rvm") }
  code <<SH
export HOME=/home/#{node[:owner_name]}
## Install git
mkdir -p $HOME/.rvm/src && cd $HOME/.rvm/src && package = git && version=1.6.5.3
curl -O http://kernel.org/pub/software/scm/git/$package-$version.tar.gz
cd $package-$version && ./configure --prefix=/usr/local && make && sudo make install
#
## Install RVM
cd $HOME/.rvm/src && git clone --depth 1 git://github.com/wayneeseguin/rvm.git && cd rvm && ./install

# Install common rubies
source $HOME/.rvm/scripts/rvm
rvm install 1.8.6,1.8.7,ree,1.9.1,jruby,rbx
SH
end
