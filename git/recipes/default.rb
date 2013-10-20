#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "git" do
  action :install
end

cookbook_file "/home/#{node[:current_user]}/.gitconfig" do
  mode 0744
  owner "#{node[:current_user]}"
  group "#{node[:current_user]}"
  action :create
end

