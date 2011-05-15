TESTS_ENVIRONMENT = $(PERL) -Mstrict -I $(top_srcdir) -w
TESTS = t/check_wordpress.t \
	t/check_cisco_load.t \
	t/check_cisco_psu.t \
	t/check_cisco_temperatures.t \
	t/check_cisco_fans.t \
	t/check_snmp_uptime.t \
	t/check_snmp_printer.t \
	t/check_snmp_interface.t \
	t/check_snmp_lm_sensors_temp.t \
	t/check_snmp_mem_simple.t \
	t/check_cisco_pix_failover.t \
	t/check_apcupsd_ups.t \
	t/check_linux_memory.t

libexec_SCRIPTS = check_wordpress.pl \
	check_snmp_printer.pl \
	check_cisco_load.pl \
	check_cisco_temperatures.pl \
	check_cisco_fans.pl \
	check_cisco_psu.pl \
	check_snmp_uptime.pl \
	check_active_calls.pl \
	check_snmp_interface.pl \
	check_snmp_lm_sensors_temp.pl \
	check_snmp_mem_simple.pl \
	check_cisco_pix_failover.pl \
	check_linux_memory.pl \
	check_apcupsd_ups.pl

CLEANFILES = $(libexec_SCRIPTS)
EXTRA_DIST = $(TESTS) \
	check_wordpress.pl.in \
	check_snmp_printer.pl.in \
	check_cisco_load.pl.in \
	check_cisco_temperatures.pl.in \
	check_cisco_fans.pl.in \
	check_cisco_psu.pl.in \
	check_snmp_uptime.pl.in \
	check_active_calls.pl.in \
	check_snmp_interface.pl.in \
	check_snmp_lm_sensors_temp.pl.in \
	check_snmp_mem_simple.pl.in \
	check_cisco_pix_failover.pl.in \
	check_linux_memory.pl.in \
	check_apcupsd_ups.pl.in

do_subst = sed -e 's,[@]VERSION[@],$(PACKAGE_VERSION),g' \
	-e 's,[@]BUGREPORT[@],$(PACKAGE_BUGREPORT),g' \
	-e 's,[@]COPYRIGHT[@],$(PACKAGE_COPYRIGHT),g' \
	-e 's,[@]PERL[@],$(PERL),g'

%.pl : %.pl.in
	$(do_subst) < $< > $@
	chmod +x $@
