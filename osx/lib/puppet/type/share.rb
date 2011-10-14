Puppet::Type.newtype(:share) do
  @doc = "Configure AFP, FTP and NFS shares on a Mac OS X Server
  The name becomes the share name unless otherwise specified."
  
  ensurable
  
  newparam(:name) do
    desc "The share name (cross-platform)."
  end
  
  newparam(:path) do
    desc "The path to the directory to be shared."
  end

  newparam(:protocols) do
    desc "Protocols enabled for this share. afp, smb, ftp or all"
    
    newvalues(:afp, :smb, :ftp, :all)
    defaultto :all
  end
  
  newparam(:afp_name) do
    desc "Share name when using the AFP protocol, this overrides the cross platform name."
  end
  
  newparam(:smb_name) do
    desc "Share name when using the SMB protocol, this overrides the cross platform name."  
  end
  
  newparam(:ftp_name) do
    desc "Share name when using the FTP protocol, this overrides the cross platform name."
  end
  
  newparam(:guest) do
    desc "Enable guest access for: afp, smb, ftp, all, or disabled"
    newvalues(:afp, :smb, :ftp, :all, :disabled)
    defaultto :disabled
  end
  
  newparam(:inherit, :boolean => true) do
    desc "Specify that AFP will use the classic privileges model to inherit, true or false"
    
    newvalues(:true, :false)
    defaultto :false
  end
  
  
end