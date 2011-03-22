TESTS_ENVIRONMENT = $(PERL) -Mstrict -I $(top_srcdir) -w
TESTS = t/check_wordpress.t \
	t/check_cisco_load.t \
	t/check_cisco_psu.t \
	t/check_cisco_temperatures.t \
	t/check_snmp_uptime.t \
	t/check_snmp_printer.t

libexec_SCRIPTS = check_wordpress.pl \
	check_snmp_printer.pl \
	check_cisco_load.pl \
	check_cisco_temperatures.pl \
	check_cisco_fans.pl \
	check_cisco_psu.pl \
	check_snmp_uptime.pl \
	check_active_calls.pl

CLEANFILES = $(libexec_SCRIPTS)
EXTRA_DIST = $(TESTS) \
	check_wordpress.pl.in \
	check_snmp_printer.pl.in \
	check_cisco_load.pl.in \
	check_cisco_temperatures.pl.in \
	check_cisco_fans.pl.in \
	check_cisco_psu.pl.in \
	check_snmp_uptime.pl.in \
	check_active_calls.pl.in

do_subst = sed -e 's,[@]VERSION[@],$(PACKAGE_VERSION),g' \
	-e 's,[@]BUGREPORT[@],$(PACKAGE_BUGREPORT),g' \
	-e 's,[@]COPYRIGHT[@],$(PACKAGE_COPYRIGHT),g' \
	-e 's,[@]PERL[@],$(PERL),g'

%.pl : %.pl.in
	$(do_subst) < $< > $@
	chmod +x $@
