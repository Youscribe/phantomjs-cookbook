#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2012, CustomInk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Packages
case node['platform_family']
when 'debian'
  %w(fontconfig libfreetype6).each do |package|
    package package
  end
when 'fedora','rhel'
  %w(fontconfig freetype).each do |package|
    package package
  end
end

basename = "phantomjs-#{node['phantomjs']['version']}-linux-#{node['kernel']['machine']}"

ark 'phantomjs' do
  version_number = node['phantomjs']['version'].split('.').map(&:to_i)
  
  if version_number[0] == 1 && version_number[1] == 9 && version_number[2] < 6 
    url "https://phantomjs.googlecode.com/files/#{basename}.tar.bz2"
  else
    url "https://bitbucket.org/ariya/phantomjs/downloads/#{basename}.tar.bz2"
  end
  has_binaries ['bin/phantomjs']
end
