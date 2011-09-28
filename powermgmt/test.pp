require 'lib/puppet/type/powermgmt.rb'
require 'lib/puppet/provider/powermgmt/powermgmt.rb'

powermgmt { "dont sleep" :
	sleep => 60,
	disk_sleep => 60,
	display_sleep => 10,
	autorestart => true,
	power_button_sleep => true,
	# wake_on_lan => true,
}	
