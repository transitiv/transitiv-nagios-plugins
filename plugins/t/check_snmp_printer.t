#!/usr/bin/perl -w -I ..
# vim: et sts=4 sw=4 ts=4

use strict;
use Test::More tests => 4;
use PluginTester;

my $plugin = './check_snmp_printer.pl';
my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unresponsive_ip = '127.127.127.127';
my $result;

# test argument handling
$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: host/, 'Missing argument output');

# test a (hopefully) unresolvable domain
$result = PluginTester->exec("${plugin} -H ${invalid_domain}");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

# test a (hopefully) non-SNMP host
$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
