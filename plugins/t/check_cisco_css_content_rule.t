#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 13;
use PluginTester;

my $plugin = './check_cisco_css_content_rule.pl';
my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unresponsive_ip = '127.254.254.100';
my $result;

# test argument handling
$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: host/, 'Missing argument output');

# test required arguments
$result = PluginTester->exec("${plugin} -H ${invalid_domain}");
ok($result->exit_status == 3, 'UNKNOWN returned with missing arguments');
like($result->output, qr/Missing argument: owner/, 'Output for missing owner argument');
like($result->output, qr/Missing argument: name/, 'Output for missing name argument');
like($result->output, qr/Missing argument: warning/, 'Output for missing warning argument');
like($result->output, qr/Missing argument: critical/, 'Output for missing critical argument');

# test warning/critical argument formats
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -o foo -n bar -w 50% -c foo");
ok($result->exit_status == 3, 'UNKNOWN returned with invalid critical argument');
like($result->output, qr/Invalid format/, 'Output for invalid critical argument');

$result = PluginTester->exec("${plugin} -H ${invalid_domain} -o foo -n bar -w bar -c 60");
ok($result->exit_status == 3, 'UNKNOWN returned with invalid warning argument');
like($result->output, qr/Invalid format/, 'Output for invalid warning argument');

# test a (hopefully) unresolvable domain
$result = PluginTester->exec("${plugin} -H ${invalid_domain} -o foo -n bar -w 60% -c 7");
ok($result->exit_status == 3, 'UNKNOWN returned for unresolvable address');

# test a (hopefully) non-SNMP host
$result = PluginTester->exec("${plugin} -H ${unresponsive_ip} -o foo -n bar -w 5 -c 70% -t 5");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
