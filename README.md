puppet-osx modules and providers
--------------------------------

This repository will contain most of my custom modules and providers
for managing mac os x clients and servers using puppet.

There isn't any working code right now. Come back later.

----

Management components to develop for:

* Application preference management via .plist merging (using plist gem at mosen/plist)
* MCX atomic configuration via understandable puppet types eg. Dock[] Finder[] etc..
* security framework automation via "security" command line utility. (Certificate trust/Keychain)
* profile installation via "profile" command line utility (OSX 10.7 Only)
* power management via pmset
* bluetooth and wifi enable/disable at the driver control utility level.
* bless? to reset netboot volume maybe?
* ipfw control?
* kerberos local KDC and local directory?
* networksetup/scutil ? (kinda deprecated in 10.7)
* manage server principals via sso_util ?
* more???
