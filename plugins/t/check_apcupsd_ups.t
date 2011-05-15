#!/usr/bin/perl -w -I ..
# vim: et sts=4 sw=4 ts=4

use strict;
use Test::More tests => 4;
use PluginTester;

my $plugin = './check_apcupsd_ups.pl';
my $result;

$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: warning/, 'Missing warning argument output');
like($result->output, qr/Missing argument: critical/, 'Missing critical argument output');

SKIP: {
    skip '/sbin/apcaccess is installed', 1 if -x '/sbin/apcaccess';

    $result = PluginTester->exec("${plugin} -w 80 -c 90");
    ok($result->exit_status == 3, 'UNKNOWN returned when apcaccess executable not found');
}
