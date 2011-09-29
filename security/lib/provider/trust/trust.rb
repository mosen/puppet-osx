Puppet::Type.type(:trust).provide :trust do
  desc "Provides certificate trust through the security command line utility."
  
  commands :security => "/usr/bin/security"
  confine :operatingsystem => :darwin
  defaultfor :operatingsystem => :darwin
  
  class << self
    
    def instances
      # Dump the admin trust settings, it's the only one that makes sense
      admin_trust_dump = security "dump-trust-settings", "-d"
      @@trusts = {}
      prev_indent = 0
      current_hash = @@trusts
      
      admin_trust_dump.each do |line|
        indent = line.count "\t"
        
        if 
        
        kv = line.strip.split(':')
        current_hash[kv[0]] = kv[1]
      end
      
      #Number of trusted certs = 1
      #Cert 0: ED2
      #   Number of trust settings : 0
      
      
      # Cert 2: 192.168.1.49
      #    Number of trust settings : 4
      #    Trust Setting 0:
      #       Policy OID            : SSL
      #       Policy String         : promise-vtrak-e610f-xsan2datameta.local
      #       Allowed Error         : CSSMERR_TP_CERT_EXPIRED
      #       Result Type           : kSecTrustSettingsResultTrustAsRoot
      
    end
    
  end
  
  def create
    #/usr/bin/security add-trusted-cert -k ~/Library/Keychains/login.keychain -d /Somecert.cer
    #security "add-trusted-cert", "-k", @resource[:keychain], "-d", @resource[:source]
  end
  
  def destroy
    #security "remove-trusted-cert", "-d", @resource[:source]
  end
  
  def exists?
    # dump trust settings
    # security dump-trust-settings -d
    # TODO: prefetch trust dump?
  end
end