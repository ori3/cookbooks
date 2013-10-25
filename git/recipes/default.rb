#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

raise 'invalid parame node[:git][:user][:name]' if node[:git][:user][:name].empty?

package "git" do
  action :install
end

template "/home/#{node[:current_user]}/.gitconfig" do
  mode 0744
  owner "#{node[:current_user]}"
  group "#{node[:current_user]}"
  action :create
  variables({
      :user =>
        {
            :name => node[:git][:user][:name],
            :email => node[:git][:user][:email],
        }
  })
end

