#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "git" do
  action :install
end

package "libncurses5-dev" do
  action :install
end

directory "/home/#{node[:user]}/.vim/bundle" do
  mode 0744
  owner "#{node[:user]}"
  group "#{node[:user]}"
  recursive true
end

git "/home/#{node[:user]}/.vim/bundle/vundle" do
  repository "https://github.com/gmarik/vundle.git"
  action :sync
  user "#{node[:user]}"
end


bash "install_vim73" do
  user "#{node[:user]}"
  cwd "/home/#{node[:user]}"
  code <<-EOH

wget http://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
tar jxf vim-7.3.tar.bz2
mkdir vim73/patches
cd vim73/patches
wget http://ftp.vim.org/pub/vim/patches/7.3/7.3.00{1..9}
wget http://ftp.vim.org/pub/vim/patches/7.3/7.3.0{10..99}
wget http://ftp.vim.org/pub/vim/patches/7.3/7.3.{100..999}
cd ..
cat patches/7.3.* | patch -p0
./configure --prefix=/home/#{node[:user]}/local --enable-multibyte --with-features=huge
make
make install

  EOH

  not_if "vi --version | grep 7.3"
end

template "/home/#{node[:user]}/.vimrc" do
  mode 0744
  owner "#{node[:user]}"
  group "#{node[:user]}"
end

%w{ vi vim }.each do |vim_name|
  execute "echo 'alias #{vim_name}=/home/#{node[:user]}/local/bin/vim' >> /home/#{node[:user]}/.bashrc" do
    user "#{node[:user]}"
    not_if "grep 'alias #{vim_name} /home/#{node[:user]}/.bashrc "
  end
end
