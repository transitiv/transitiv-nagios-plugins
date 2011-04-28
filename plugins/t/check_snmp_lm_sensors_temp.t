#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 7;
use PluginTester;
use IO::Socket;

my $plugin = './check_snmp_lm_sensors_temp.pl';
my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unresponsive_ip = '127.254.254.100';
my $result;

$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: host/, 'Missing host argument output');
like($result->output, qr/Missing argument: name/, 'Missing name argument output');
like($result->output, qr/Missing argument: warning/, 'Missing warning argument output');
like($result->output, qr/Missing argument: critical/, 'Missing critical argument output');

$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 30 -c 40");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -w 30 -c 40");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');

