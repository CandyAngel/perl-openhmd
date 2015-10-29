#!/usr/bin/env perl

use strict;
use warnings;

use OpenHMD::Backend::Inline qw(:all);

my $context = ohmd_ctx_create() or die 'Failed to create context';

my $count = ohmd_ctx_probe($context);
die sprintf 'Failed to probe devices: %s', ohmd_ctx_get_error($context)
    if $count < 0;
printf "Devices: %i\n\n", $count;

my $print_gets = sub {
    my ($title, $index, $type) = @_;
    my $value = ohmd_list_gets($context, $index, $type);

    printf "    %-8s:   %s\n", $title, $value;
};

foreach my $index (0 .. $count - 1) {
    printf "Device %i\n", $index;
    $print_gets->('Vendor', $index, $OHMD_VENDOR);
    $print_gets->('Product', $index, $OHMD_PRODUCT);
    $print_gets->('Path', $index, $OHMD_PATH);
    print "\n";
}

ohmd_ctx_destroy($context);
