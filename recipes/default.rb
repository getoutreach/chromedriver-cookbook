#
# Cookbook Name:: chromedriver
# Recipe:: default
#
# Copyright (c) 2013 Rally Software Development Corp
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

package 'unzip'

remote_file node[:chromedriver][:full_path] do
  source node[:chromedriver][:source_url]
  notifies :run, 'execute[unzip_chromedriver]', :immediately
end

execute 'unzip_chromedriver' do
  command "unzip -j -o #{node[:chromedriver][:full_path]} chromedriver -d #{node[:chromedriver][:path]}"
  action :nothing
  notifies :touch, "file[#{node[:chromedriver][:path]}/chromedriver]"
end

file "#{node[:chromedriver][:path]}/chromedriver" do
  owner node[:chromedriver][:owner]
  group node[:chromedriver][:group]
  mode node[:chromedriver][:mode]
  action :nothing
end
