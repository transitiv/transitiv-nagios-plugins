AC_PREREQ([2.65])
AC_INIT([transitiv-nagios-plugins], [0.7], [nagios@transitiv.co.uk])
AC_SUBST(PACKAGE_COPYRIGHT,
  "Copyright 2011 (c) Transitiv Technologies <info@transitiv.co.uk>"
)
AM_INIT_AUTOMAKE([color-tests dist-bzip2 foreign no-dist-gzip parallel-tests])

# Check for perl
AC_PATH_PROG([PERL], perl, perl)

# Check for required perl modules
# Taken from http://ac-archive.sourceforge.net/ac-archive/ac_prog_perl_modules.html
# Written by Dean Povey <povey@wedgetail.com>
AC_DEFUN([AC_PROG_PERL_MODULES],[dnl
ac_perl_modules="$1"
ac_perl_modules_failed=0
for ac_perl_module in $ac_perl_modules; do
  AC_MSG_CHECKING([for perl module $ac_perl_module])

  # Would be nice to log result here, but can't rely on autoconf internals
  $PERL "-M$ac_perl_module" -e exit > /dev/null 2>&1
  if test $? -ne 0; then
    AC_MSG_RESULT([no]);
    ac_perl_modules_failed=1
 else
    AC_MSG_RESULT([ok]);
  fi
done

# Run optional shell commands
if test "$ac_perl_modules_failed" = 0; then
  :
  $2
else
  :
  $3
fi])dnl

AC_PROG_PERL_MODULES([Nagios::Plugin LWP::UserAgent Net::SNMP],,
  AC_MSG_ERROR([One or more required Perl modules are missing]))

AC_MSG_CHECKING([whether to install PNP4Nagios templates])
AC_ARG_WITH([pnp-templates],
  AS_HELP_STRING([--with-pnp-templates=DIR],
    [Specify location to install PNP4Nagios templates @<:@default=DATAROOTDIR/pnp4nagios/html/templates@:>@]),
  AC_MSG_RESULT([$with_pnp_templates]), AC_MSG_RESULT([no])
)

# set the default template location if no path is supplied
if test "x$with_pnp_templates" = xyes ; then
  with_pnp_templates='${datarootdir}/pnp4nagios/templates'
fi

AC_SUBST(pnpdir, [$with_pnp_templates])
AM_CONDITIONAL([PNPTEMPLATES],
  [test -n "${with_pnp_templates}" && test "${with_pnp_template+no}" != no])

AC_CONFIG_FILES([
	Makefile
	nagios-config/Makefile
	plugins/Makefile
	pnptemplates/Makefile
])
AC_OUTPUT
