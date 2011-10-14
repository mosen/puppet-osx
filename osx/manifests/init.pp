# Examples for custom providers

class osx {

	powermgmt { "dont sleep" :
		source              => all,
		sleep               => 0,
		disk_sleep          => 60,
		display_sleep       => 10,
		autorestart         => true,
		power_button_sleeps => true,
	}
	
 	certificate_trust { "test": 
		source => "/Users/Shared/test.cer",
		ensure => absent,
	}
}
