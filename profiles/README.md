Mac OS X 10.7 Lion Configuration Profiles
=========================================

For the moment this is just a scratch pad for ideas! There is *no* implementation!

Generating profiles
-------------------

* Create an API that generates profiles.
* The iOS profile spec shows that most profile entries have a sort of base
class for establishing dates / times / UUID's, so the API model should reflect that.
* Hopefully make the API smart enough to be extensible for new types of entries should
they exist. In the past, the new types have had more or less the same structure as any
of the previous entry types.

1. iOS Configuration Profile Key Reference:
http://developer.apple.com/library/ios/#featuredarticles/iPhoneConfigurationProfileRef/Introduction/Introduction.html

Installing profiles
-------------------

* Installation, Removal, Enumeration is available via command line tool `Profiles`
* As far as I know, no public API for profile installation, ConfigurationProfiles.framework is private. And we can't
use the Cocoa bridge anyway.
* Enrollment and trust profiles can be copied into a folder.. forget which one :) (see deploystudio's implementation) to enroll at boot time. SCEP/MDM enrollment
kinda runs against the Puppet design so this may not be worth considering.

1. Installing profiles via `Profiles` tool: http://krypted.com/iphone/profile-manager-and-profiles/

Exists? profiles
----------------

Puppet needs a way of determining the existence of profiles.

* `Profiles -P` ? enumerates profiles but doesn't deal with duplicates.. 
so the output wouldn't indicate which users had which profiles. For the system level profiles all is good.
* ConfigurationProfile framework ends up writing profiles to `/var/db/ConfigurationProfiles/Store`
* More research needed on the mdmclient -> ConfigurationProfile.framework -> /var/db process.

Identifying profiles installed by Puppet vs Externally managed profiles
-----------------------------------------------------------------------

* Enumeration of profiles displays the PayloadUUID as the primary ID method
* Apple says `The actual content is unimportant, but it must be globally unique.`
* Therefore we can use puppet-version-uuid prefixed UUIDs to ensure we know which are managed via Puppet.
* The profiles tool needs to remove the profile via the organisation name, so this needs to be unique too.

More notes on Profiles
----------------------

krypted also casts some light on post-profile tasks like FileVault wiping:

```Once installed, mdmclient, a binary located in /usr/libexec will process changes such as wiping a system that has been FileVaulted (note you need to FileVault if you want to wipe an OS X Lion client computer). /System/Library/LaunchDaemons and /System/Library/LaunchAgents has a mdmclient daemon and agent respectively that start it up automatically.```


Puppet Module and Type Design
=============================

The design has to accomodate for the fact that the profile file-format deals with payloads as individual entities, but the file itself and its organisation name are the unique identifier. So this leaves us with a hard decision on the namevar.

* We could assume that all payloads delivered via Puppet are part of one file. This makes management easier on the part of
puppet, but neglects the difference between user and device payloads. Also, how do we generate the PayloadUUID and not store
it anywhere with puppet? the UUID AND organisation name would have to be repeatable. In this scenario we still need to
deal with removal of individual payloads by reinstalling the entire configuration profile.

* We could assume that every delivered payload is a separate file. This means that we can delete settings atomically by removing the profile associated with the single puppet entry (if we use ensurable and ensure => absent). Again we have to use a repeatable method of generating the PayloadUUID so that we can remove it later, ditto for the org name.

* For the previous issues, a hack might be to let the puppet admin specify an org name/uuid as a part of the profile resource

* We could also use the module namespace to generate the org/uuid as a kind of translation from the module manifest to the set of payloads?

Puppet Type
===========


Payload
-------
* ensurable. absent means `Profiles -R`, present means `Profiles -I`. exists? via `Profiles -P`.
* namevar corresponds to PayloadUUID and org.name.x, maybe com.puppetlabs.profile.mynamevar+filter+tolower (But if we change the namevar, the old settings won't be uninstalled?).

Sub-Types
---------

Each type of payload is sufficiently complex to be overwhelming to describe as a collection of attributes in a giant Payload type. Probably unmanageable too. Let's try specific sub-types

Payload::Email
--------------

This is pretty user specific and therefore outside of the domain of puppet on other platforms, but im trying to get
a feel for what the type would look like in its implementation.

```
payload::email {
	ensure => present,
	uuid => "????",
	organisation => "com.puppetlabs.profiles.email",

	description => "Work E-mail", # [EmailAccountDescription]
	account     => "workemail",      # [EmailAccountName]
	address     => "%@@workdotcom",  # [EmailAddress]
	auth        => "password",       # |"none" [IncomingMailServerAuthentication]
	host        => "mail.workdotcom",# [IncomingMailServerHostName]
	port        => "993",            # [IncomingMailServerPortNumber]
	use_ssl     => true,             # [IncomingMailServerUseSSL]
	username    => "%@",             # [IncomingMailServerUsername]
	password    => "xyz",            # [IncomingPassword]	or undefined for user prompt
	# ... outgoing settings
	prevent_move => true,		  # [PreventMove]
	prevent_appsheet => true,     # [PreventAppSheet]
}
```
