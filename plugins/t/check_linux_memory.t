#!/usr/bin/perl -w -I ..
# vim: et sts=4 sw=4 ts=4

use strict;
use Test::More tests => 4;
use PluginTester;

my $plugin = './check_linux_memory.pl';
my $result;

$result = PluginTester->exec($plugin);
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: warning/, 'Missing warning argument output');
like($result->output, qr/Missing argument: critical/, 'Missing critical argument output');

SKIP: {
    skip "must be run on Linux", 1 unless $^O eq 'linux';

    $result = PluginTester->exec("${plugin} -w 0 -c 0");
    ok($result->exit_status == 2, 'CRITICAL returned with critical argument at 0%');
};
