#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 11;
use PluginTester;
use IO::Socket;

my $plugin = './check_snmp_mem_simple.pl';
my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unresponsive_ip = '127.254.254.100';
my $result;

$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: host/, 'Missing argument output');

$result = PluginTester->exec("${plugin} -H ${invalid_domain}");
ok($result->exit_status == 3, 'UNKNOWN returned with missing arguments');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 90");
ok($result->exit_status == 3, 'UNKNOWN returned with missing critical argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

$result = PluginTester->exec("${plugin} -H ${invalid_domain} -c 95");
ok($result->exit_status == 3, 'UNKNOWN returned with missing warning argument');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');

$result = PluginTester->exec("${plugin} -H ${invalid_domain} -w 90 -c 95");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -w 90 -c 95 -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');

