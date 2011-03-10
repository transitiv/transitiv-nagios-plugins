# vim: et sts=4 sw=4 ts=4
#
# Copyright 2011 (c) Transitiv Technologies <info@transitiv.co.uk>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

package PluginTester;

use strict;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub exec {
    my $class = shift;
    my $cmd = shift or die 'You must specify a command';
    my $self = $class->new;

    print "Executing `${cmd}'\n";
    my $out = qx($cmd);
    
    if ($? == -1) {
        die "failed to execute $!";
    } elsif ($? & 127) {
        die sprintf(
            "`%s' died with signal %d",
            ($? & 127), $!
        );
    } else {
        $self->{'exit_status'} = $? >> 8;
    }

    chomp $out;

    $self->{'output'} = $out;

    return $self;
}

sub exit_status {
    my $self = shift;
    return $self->{'exit_status'};
}

sub output {
    my $self = shift;
    return $self->{'output'};
}

1;
