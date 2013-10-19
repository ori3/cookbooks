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

#template "/home/#{node[:user]}/.vimrc" do
#  mode 0400
#  owner "#{node[:user]}"
#  group "#{node[:user]}"
#end
