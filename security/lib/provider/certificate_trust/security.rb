Puppet::Type.type(:certificate_trust).provide :security, :parent => Puppet::Provider do
  desc "Provides certificate trust through the security command line utility."
  
  commands :security => "/usr/bin/security"
  confine :operatingsystem => :darwin
  defaultfor :operatingsystem => :darwin
  
  def self.prefetch(resources)

    # Dump the admin trust settings, it's the only one that makes sense to manage
    admin_trust_dump = security "dump-trust-settings", "-s"
    trusts = {}
    
    admin_trust_dump.each do |line|
      next if line.match /Number of trusted certs/ # Dont care
      next if line.match /Number of trust settings/ # Dont care
      
      case
      when line.match(/Cert [0-9]*/)
        # key the hash by the certificate common name
        cn = line.split(':', 2)[1].lstrip.rstrip
        trusts[cn] = {}
      when line.match(/Trust Setting [0-9]*/)
        setting_index = line.gsub(/Trust Setting ([0-9]*):/, '\1')
        trusts[cn][setting_index] = {}
      else
        # Specific trust properties, in the case of a root CA this will normally be blank
        kv = line.strip.split(':')
        trusts[cn][setting_index][kv[0].strip] = kv[1].lstrip
      end
    end
    
    info(trusts.inspect)    
  end
  
  # TODO: this does not even run  
  def self.instances

    # Cert 2: 192.168.1.49
    #    Number of trust settings : 4
    #    Trust Setting 0:
    #       Policy OID            : SSL
    #       Policy String         : promise-vtrak-e610f-xsan2datameta.local
    #       Allowed Error         : CSSMERR_TP_CERT_EXPIRED
    #       Result Type           : kSecTrustSettingsResultTrustAsRoot
    []
  end
  
  def create
    info('trustcreate')
    #/usr/bin/security add-trusted-cert -k ~/Library/Keychains/login.keychain -d /Somecert.cer
    #security "add-trusted-cert", "-k", @resource[:keychain], "-d", @resource[:source]
  end
  
  def destroy
    info('trustdestroyy')
    #security "remove-trusted-cert", "-d", @resource[:source]
  end
  
  def exists?
    info('trustexists')
    # dump trust settings
    # security dump-trust-settings -d
    # TODO: prefetch trust dump?
  end
end