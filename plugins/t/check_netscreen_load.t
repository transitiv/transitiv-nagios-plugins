#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 15;
use PluginTester;

my $plugin = './check_netscreen_load.pl';
my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unresponsive_ip = '127.254.254.100';
my $result;

# test argument handling
$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: host/, 'Missing argument output');

# test missing critical/warning arguments
$result = PluginTester->exec("${plugin} -H ${invalid_domain}");
ok($result->exit_status == 3, 'UNKNOWN returned with missing arguments');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

# test missing critical argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 60,70,80");
ok($result->exit_status == 3, 'UNKNOWN returned with missing critical argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

# test missing warning argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -c 60,70,80");
ok($result->exit_status == 3, 'UNKNOWN returned with missing warning argument');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');

# test invalid critical argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 60,70,80 -c 90");
ok($result->exit_status == 3, 'UNKNOWN returned with invalid critical argument');
like($result->output, qr/Invalid format for critical argument/, 'Output for invalid critical argument');

# test invalid warning argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -c 60,70,80 -w 80");
ok($result->exit_status == 3, 'UNKNOWN returned with invalid warning argument');
like($result->output, qr/Invalid format for warning argument/, 'Output for invalid warning argument');

# test a (hopefully) unresolvable domain
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 60,70,80 -c 70,80,90");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

# test a (hopefully) non-SNMP host
$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -w 60,70,80 -c 70,80,90 -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
