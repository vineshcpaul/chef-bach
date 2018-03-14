#
# Cookbook Name:: bcpc-hadoop
# Definition:: hdp_repo
#
# Copyright 2016, Bloomberg Finance L.P.
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

#
# This recipe uses the 'bcpc_repo' definition from the bcpc cookbook
# to define Hortonworks Data Platform apt repos using 'bcpc'
# attributes.
#
bcpc_repo 'hortonworks' do
  arch 'amd64'
end

bcpc_repo 'hortonworks-gpl' do
  arch 'amd64'
end

bcpc_repo 'hdp-utils' do
  arch 'amd64'
end

bcpc_repo 'hdp-utils-gpl' do
  arch 'amd64'
end

