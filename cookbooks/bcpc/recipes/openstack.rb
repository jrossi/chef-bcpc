#
# Cookbook Name:: bcpc
# Recipe:: openstack
#
# Copyright 2013, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "bcpc::default"
include_recipe "bcpc::packages-openstack"

%w{ python-novaclient
    python-cinderclient
    python-glanceclient
    python-nova
    python-memcache
    python-keystoneclient
    python-nova-adminclient
    python-heatclient
    python-ceilometerclient
    python-mysqldb
    python-six
    python-ldap
    python-openstackclient
}.each do |pkg|
    package pkg do
        action :upgrade
    end
end

%w{hup_openstack logwatch}.each do |script|
    template "/usr/local/bin/#{script}" do
        source "#{script}.erb"
        mode 0755
        owner "root"
        group "root"
        variables(:servers => get_head_nodes)
    end
end