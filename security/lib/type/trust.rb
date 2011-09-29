# Manage Certificate Trust Settings
Puppet::Type.newtype(:trust) do
  @doc = "Manage certificate trust settings."
  ensurable
    
  newparam(:name) do
    desc "The CN (Common Name) of the certificate" # TODO: something that makes more sense from looking at the code.
    isnamevar
  end
  
  # 
  # newparam(:source) do
  #   desc "The certificate file to trust (in DER or PEM format)"
  # end
  # 
  # newparam(:adminstore) do
  #   # This should always be true to avoid interactive authentication.
  #   desc "Add the trust setting using the admin store. If false then interactive authentication would occur."
  #   
  #   newvalue(:true)
  #   newvalue(:false)
  #   defaultto :true
  # end
  # 
  # newparam(:resulttype) do
  #   desc "How to trust the specified certificate."
  # 
  #   newvalue(:trustroot)
  #   newvalue(:trustasroot)
  #   newvalue(:deny)
  #   newvalue(:unspecified)
  # end
  # 
  # newparam(:policy) do
  #   desc "Specify policy constraint"
  #   
  #   newvalue(:ssl)
  #   newvalue(:smime)
  #   newvalue(:codesign)
  #   newvalue(:ipsec)
  #   newvalue(:ichat)
  #   newvalue(:basic)
  #   newvalue(:swupdate)
  #   newvalue(:pkgsign)
  #   newvalue(:pkinitclient)
  #   newvalue(:pkinitserver)
  #   newvalue(:eap)
  #   # Default is no policy constraints
  # end
  # 
  # newparam(:app_path) do
  #   desc "Constrain to application at path..."
  #   # Default is no policy constraints
  # end
  # 
  # newparam(:policy_string) do
  #   desc "Specify policy-specific string"
  #   # Default is no policy constraints
  # end
  # 
  # newparam(:allowed_error) do
  #   desc "Specify allowed error (integer value or one of: certExpired, hostnameMismatch)"
  #   
  #   newvalues(/[0-9]+/, :certexpired, :hostnamemismatch)
  #   # Default is no allowed errors
  # end
  # 
  # newparam(:key_usage) do
  #   desc "Specify key usage, an integer"
  # end
  # 
  # newparam(:keychain) do
  #   desc "Specify the keychain filename to add this trust policy."
  #   defaultto "/Library/Keychains/System.keychain"
  # end
  
end