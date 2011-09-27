Puppet::Type.type(:trust).provide :security do
  desc "Provides certificate trust through the security command line utility."
  
  commands :security => "/usr/bin/security"
  confine :operatingsystem => :darwin
  defaultfor :operatingsystem => :darwin
  
  def self.instances
    
  end
  
  def create
    #/usr/bin/security add-trusted-cert -k ~/Library/Keychains/login.keychain -d /Somecert.cer
    security "add-trusted-cert", "-k", @resource[:keychain], "-d", @resource[:source]
  end
  
  def destroy
    security "remove-trusted-cert", "-d", @resource[:source]
  end
  
  def exists?
    # dump trust settings
    # security dump-trust-settings -d
    # TODO: prefetch trust dump?
  end
end