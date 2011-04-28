#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 13;
use PluginTester;
use IO::Socket;

my $plugin = './check_snmp_mem_simple.pl';
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
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 90");
ok($result->exit_status == 3, 'UNKNOWN returned with missing critical argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

# test missing warning argument
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -c 95");
ok($result->exit_status == 3, 'UNKNOWN returned with missing warning argument');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');

# test a (hopefulle) unresolvable domain
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 90 -c 95");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');
like($result->output, qr{Unable to resolve UDP/IPv4 address '\Q$invalid_domain'}, 'Output for unresolvable address');

# test a (hopefully) non-SNMP host
$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -w 90 -c 95 -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
like($result->output, qr/No response from remote host '\Q${unresponsive_ip}'/, 'Output for unresponsive host');

