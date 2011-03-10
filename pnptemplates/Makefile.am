if PNPTEMPLATES
pnp_DATA = check_cisco_load.php
else
pnp_DATA =
endif

EXTRA_DIST = check_cisco_load.php.in
CLEANFILES = $(pnp_DATA)

do_subst = sed -e 's,[@]PACKAGE_STRING[@],$(PACKAGE_STRING),g' \
	-e 's,[@]COPYRIGHT[@],$(PACKAGE_COPYRIGHT),g' 

%.php: %.php.in
	$(do_subst) < $< > $@
