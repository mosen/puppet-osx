Mac OS X Power Management Resource Type for Puppet
====

This is a simple power management type which uses `pmset` to control power management.

**Limitation:** currently pmset only reports the *ACTIVE* profile, and so this isn't very useful for
dealing with laptop power management unless you would like the same profile regardless of whether the
system is running on battery or not.

Example
====

```ruby

powermgmt { "never sleep":
	sleep => 0, # System sleep time (in minutes)
	disk_sleep => 0, # Disk spin down time (in minutes)
	display_sleep => 0, # Display sleep time (in minutes)
	wake_on_lan => true, # Turn on wake on lan
	power_button_sleeps => true, # Pressing the power button sleeps instead of shutting down.
	autorestart => true, # Automatically restart on power outage.
}

```