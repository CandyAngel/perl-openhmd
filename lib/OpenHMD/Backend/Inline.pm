package OpenHMD::Backend::Inline;

use strict;
use warnings;

use Carp;

use Exporter qw(import);

use Inline (
    C       => 'DATA',
    libs    => '-lopenhmd',
);

our %EXPORT_TAGS = (
    functions => [qw(
        ohmd_ctx_create
        ohmd_ctx_destroy
    )],
);

do {
    my %seen;
    push @{ $EXPORT_TAGS{'all'} },
        grep { !$seen{$_}++ }
        map  { @{ $EXPORT_TAGS{$_} } }
            keys %EXPORT_TAGS;
};

Exporter::export_ok_tags('all');

sub ohmd_ctx_create {
    croak 'Too many arguments' if scalar @_ > 0;

    return _inline_ohmd_ctx_create();
}

sub ohmd_ctx_destroy {
    croak 'Too few arguments'  if scalar @_ < 1;
    croak 'Too many arguments' if scalar @_ > 1;

    _inline_ohmd_ctx_destroy(@_);
}

1;

__DATA__

__C__

#include <openhmd/openhmd.h>

int _inline_ohmd_ctx_create() {
    return ohmd_ctx_create();
}

void _inline_ohmd_ctx_destroy(int ctx) {
    ohmd_ctx_destroy(ctx);
}
