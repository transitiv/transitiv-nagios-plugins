# Transitiv Nagios Plugins

This package contains several useful Nagios/Icinga plugins, complete
with configuration files, PNP4Nagios templates and tests.

All plugins support being run by the Nagios embedded perl interpreter (EPN).
This aids performance on large installations (see the relevant Nagios
documentation for further info).

## Requirements

* Perl (http://www.perl.org)
* Nagios::Plugin (http://search.cpan.org/dist/Nagios-Plugin/)
* Net::SNMP (http://search.cpan.org/dist/Net-SNMP/)
* LWP::UserAgent (http://search.cpan.org/perldoc?LWP::UserAgent)

## Plugins

### SNMP

* `check_cisco_fans.pl` Checks the status of fans on Cisco devices
  supporting the CISCO-ENVMON-MIB.
* `check_cisco_load.pl` Checks the CPU load average against user defined
  thresholds on Cisco devices supporting the CISCO-PROCESS-MIB or
  the OLD-CISCO-CPU-MIB.
* `check_cisco_psu.pl` Checks the status of power supply units on Cisco
  devices supporting the CISCO-ENVMON-MIB.
* `check_cisco_temperatures.pl` Checks the status of temperature sensors
  on Cisco devices supporting the CISCO-ENVMON-MIB.
* `check_snmp_printer.pl` Checks the status of a printer supporting the
  RFC1759 printer MIB (this should include pretty much all networkable
  printers with SNMP functionality).
* `check_active_calls.pl` Checks the number of active calls on devices
  supporting the DIAL-CONTROL-MIB.
* `check_snmp_uptime.pl` Checks the uptime of a device via SNMP (useful
  if a device has a habit of rebooting before Nagios can notice).
* `check_cisco_pix_failover.pl` Checks the status of a failover
  configuration on a Cisco PIX firewall.
* `check_snmp_interface.pl` Checks the status of a network interface via
  SNMP. 64 bit counters are supported in conjunction with SNMPv2.
  Performance data is returned for link speed and input/output octets.

### Other

* `check_wordpress.pl` Checks whether a WordPress website is running the
  latest available version by querying the WordPress API. The site must
  include a generator meta tag in order for the plugin to ascertain the
  currently installed version (this is the default in most themes).
* `check_apcupsd_ups.pl` Checks the status of a UPS using apcupsd.
  Alerts will also be generated if the load percentage on the UPS
  exceeds that specified by the warning and critical command line
  arguments. Performance data is returned for various attributes,
  including load, line voltage, battery charge, temperature, output
  voltage and battery voltage.
* `check_linux_memory.pl` A simple plugin that checks the amount of
  physical memory available to applications on a Linux system.

## Installation

This package uses GNU autotools for configuration and installation.

If you have cloned the git repository then you will need to run
`autoreconf` to generate the required files.

Run `./configure --help` to see a list of available install options. The
default locations for included files are as follows:

* Plugins are installed into `LIBEXECDIR`
* Nagios configuration files are installed into `SYSCONFDIR`
* PNP4Nagios templates are installed into `DATAROOTDIR/pnp4nagios/templates`
  if `--with-pnp-templates` is passed as an argument to the configure
  script. If your installation stores templates in a different directory
  you can append the path to the argument (see below).

It is highly likely that you will want to customise these locations to
suit your needs, i.e.:

	./configure --prefix=/usr \
		--libexecdir=/usr/lib/nagios/plugins
		--sysconfdir=/etc/nagios3/conf.d \
		--with-pnp-templates=/usr/local/share/pnp4nagios/templates

After `./configure` has completed successfully run `make install` and
you're done!

Note that it is recommended to run the tests before installing, see
below for information.

## Tests

Some basic plugin tests are included by default. Owing to the fact
that most plugins involve communication with external hosts, it is
extremely difficult to write a suite of tests that are both
comprehensive and portable.

You can invoke the test suite by running `make check`.

## Bugs

If you find a bug in any of the plugins please create an issue
in the project bug tracker at
https://github.com/transitiv/transitiv-nagios-plugins/issues.
