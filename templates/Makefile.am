if PNPTEMPLATES
pnp_DATA = check_cisco_load.php \
	check_active_calls.php \
	check_snmp_mem_simple.php \
	check_snmp_interface.php \
	check_linux_memory.php \
	check_apcupsd_ups.php \
	check_cisco_memory.php \
	check_cisco_css_content_rule.php \
	check_snmp_processor_load.php \
	check_snmp_storage.php
else
pnp_DATA =
endif

EXTRA_DIST = check_cisco_load.php.in \
	check_active_calls.php.in \
	check_snmp_mem_simple.php.in \
	check_snmp_interface.php.in \
	check_linux_memory.php.in \
	check_apcupsd_ups.php.in \
	check_cisco_memory.php.in \
	check_cisco_css_content_rule.php.in \
	check_snmp_processor_load.php.in \
	check_snmp_storage.php.in

CLEANFILES = $(pnp_DATA)

do_subst = sed -e 's,[@]PACKAGE_STRING[@],$(PACKAGE_STRING),g' \
	-e 's,[@]COPYRIGHT[@],$(PACKAGE_COPYRIGHT),g' 

%.php: %.php.in
	$(do_subst) < $< > $@
