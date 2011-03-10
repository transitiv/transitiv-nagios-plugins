sysconf_DATA = check_wordpress.cfg \
	check_cisco_fans.cfg \
	check_cisco_load.cfg \
	check_cisco_psu.cfg \
	check_cisco_temperatures.cfg \
	check_snmp_printer.cfg
EXTRA_DIST = check_wordpress.cfg.in \
	check_cisco_fans.cfg.in \
	check_cisco_load.cfg.in \
	check_cisco_psu.cfg.in \
	check_cisco_temperatures.cfg.in \
	check_snmp_printer.cfg.in
CLEANFILES = $(sysconf_DATA)

do_subst = sed -e 's,[@]PLUGINDIR[@],$(libexecdir),g'

%.cfg : %.cfg.in
	$(do_subst) < $< > $@

