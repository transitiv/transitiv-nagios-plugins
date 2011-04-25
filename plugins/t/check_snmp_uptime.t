#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 15;
use PluginTester;

my $plugin = './check_snmp_uptime.pl';
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
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 30m");
ok($result->exit_status == 3, 'UNKNOWN returned with missing critical argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

# test missing warning argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -c 5m");
ok($result->exit_status == 3, 'UNKNOWN returned with missing warning argument');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');

# test invalid warning argument format
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 20minutes -c 30m");
ok($result->exit_status == 3, 'UNKNOWN return with invalid warning argument format');
like($result->output, qr/Invalid format for warning argument/, 'Output for invalid warning argument');

# test invalid warning argument format
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 20m -c 30hours");
ok($result->exit_status == 3, 'UNKNOWN return with invalid critical argument format');
like($result->output, qr/Invalid format for critical argument/, 'Output for invalid critical argument');

# test a (hopefully) unresolvable domain
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 30m -c 5m");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

# test a (hopefully) non-SNMP host
$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -w 30m -c 5m -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
