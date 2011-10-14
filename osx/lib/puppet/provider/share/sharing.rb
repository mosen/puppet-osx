Puppet::Type.type(:share).provide :sharing, :parent => Puppet::Provider do
  
  desc "Create, Remove and Modify shares on Mac OS X"
  
  commands :sharing => "/usr/sbin/sharing"
  confine :operatingsystem => :darwin
  defaultfor :operatingsystem => :darwin
  
  class << self
    
    #tokens = [':', '{', '}', "\n\n"]
    tokens_regex = /[:{}\n]/
    #
    #		List of Share Points 
    # name:   Groups
    # path:   /Groups
    #   afp:  {
    #         name: Groups
    #         shared: 1
    #         guest access: 0
    #         inherit perms:  0
    #   }
    #   ftp:  {
    #         name: Groups
    #         shared: 0
    #         guest access: 0
    #   }
    #   smb:  {
    #         name: Groups
    #         shared: 1
    #         guest access: 0
    #   }
    # 
    # 
    
    def prefetch(resource)
      output = sharing, "-l"
      shares = self.parse_shares(output)
    end
    
    def next_token(str)
      str.index(tokens_regex)
    end
    
    def parse_shares(output)
      toki = next_token(output)
      
      # if colon then the preceding chars are label
      # if brace open then preceding label was a hash
      # if brace close then preceding k/v's were hash content
      case output[toki]
      when ':' # preceding text is a label, following is a value
        puts 'label'
      when '{' # start hash
        puts 'hashstart'
      when '}'
        puts 'hashend'
      when "\n"
        puts 'close k/v'
      end
      
    end
    
  end
  
end