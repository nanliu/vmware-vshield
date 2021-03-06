# Copyright (C) 2013 VMware, Inc.
require 'pathname'
vmware_module = Puppet::Module.find('vmware', Puppet[:environment].to_s)
require File.join vmware_module.path, 'lib/puppet/property/vmware'

Puppet::Type.newtype(:vshield_dns) do
  @doc = 'Manage vShield dns service'

  newparam(:scope_name, :namevar => true) do
    desc 'name of the vshield edge to enabled the dns service on'
  end

  newproperty(:dns_servers, :array_matching => :all, :sort => :false, :parent => Puppet::Property::VMware_Array ) do
    desc 'these are the dns servers which vshield points to'
    defaultto([])
  end

  newproperty(:enabled) do
    desc 'whether or not this service should be enabled'
    newvalues(:false, :true)
    defaultto(:false)
  end

  autorequire(:vshield_edge) do
    self[:name]
  end

end
