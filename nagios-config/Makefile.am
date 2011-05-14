sysconf_DATA = check_wordpress.cfg \
	check_cisco_fans.cfg \
	check_cisco_load.cfg \
	check_cisco_psu.cfg \
	check_cisco_temperatures.cfg \
	check_snmp_printer.cfg \
	check_snmp_uptime.cfg \
	check_active_calls.cfg \
	check_cisco_pix_failover.cfg \
	check_linux_memory.cfg

EXTRA_DIST = check_wordpress.cfg.in \
	check_cisco_fans.cfg.in \
	check_cisco_load.cfg.in \
	check_cisco_psu.cfg.in \
	check_cisco_temperatures.cfg.in \
	check_snmp_printer.cfg.in \
	check_snmp_uptime.cfg.in \
	check_active_calls.cfg.in \
	check_cisco_pix_failover.cfg.in \
	check_linux_memory.cfg.in

CLEANFILES = $(sysconf_DATA)

do_subst = sed -e 's,[@]PLUGINDIR[@],$(libexecdir),g'

%.cfg : %.cfg.in
	$(do_subst) < $< > $@

