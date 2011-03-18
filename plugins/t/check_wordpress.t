#!/usr/bin/perl -w -I ..

use strict;
use Test::More tests => 12;
use PluginTester;
use IO::Socket;

my $invalid_domain = 'invalid-domain-that-doesnt-exist.co.uk';
my $unroutable_ip = '240.240.240.50';
my $unresponsive_ip = '127.254.254.100';
my $result;


# test argument handling
$result = PluginTester->exec('./check_wordpress.pl');
ok($result->exit_status == 3, 'UNKNOWN returned with no arguments'); 
like($result->output, qr/Missing argument: address/, 'Missing argument output');

$result = PluginTester->exec('./check_wordpress.pl -H example.com');
ok($result->exit_status == 3, 'UNKNOWN returned with no address argument');
like($result->output, qr/Missing argument: address/, 'Missing argument output');

# test an unresolvable host
$result = PluginTester->exec("./check_wordpress.pl -I ${invalid_domain}");
ok($result->exit_status == 3, 'UNKNOWN returned with invalid address');
like($result->output, qr/500 Can't connect to \Q$invalid_domain\E/, 'Output for invalid address');

# test a non-routable ip address
$result = PluginTester->exec("./check_wordpress.pl -I ${unroutable_ip}");
ok($result->exit_status == 3, 'UNKNOWN returned with unroutable IP');
like($result->output, qr/500 Can't connect to \Q$unroutable_ip\E/, 'Output for unroutable IP');

# test a (hopefully) unresponsive host
$result = PluginTester->exec("./check_wordpress.pl -I ${unresponsive_ip}");
ok($result->exit_status == 3, 'UNKNOWN returned for unresponsive host');
like($result->output, qr/500 Can't connect to \Q$unresponsive_ip\E/, 'Output for unresponsive host');

SKIP: {
	my $io = IO::Socket::INET->new('google.co.uk:80');
	
	skip "Can't connect to google.co.uk", 2 unless defined($io->connected);

	$io->close;

	$result = PluginTester->exec("./check_wordpress.pl -I google.co.uk");
	ok($result->exit_status == 3, 'UNKNOWN returned when WordPress string not found');
	like(
		$result->output,
		qr/WordPress version string not found on `google\.co\.uk'/,
		'Output for missing WordPress string'
	);
}
