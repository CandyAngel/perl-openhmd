package OpenHMD::Backend::Inline;

use strict;
use warnings;

use Carp;
use Const::Fast;

use Exporter qw(import);

use Inline (
    C       => 'DATA',
    libs    => '-lopenhmd',
);

const our $OHMD_VENDOR  => 0;
const our $OHMD_PRODUCT => 1;
const our $OHMD_PATH    => 2;

const our $OHMD_S_OK                =>       0;
const our $OHMD_S_UNKNOWN_ERROR     =>      -1;
const our $OHMD_S_INVALID_PARAMETER =>      -2;
const our $OHMD_S_USER_RESERVED     => -16_384;

our %EXPORT_TAGS = (
    constants => [qw(
        $OHMD_PATH
        $OHMD_PRODUCT
        $OHMD_S_INVALID_PARAMETER
        $OHMD_S_OK
        $OHMD_S_UNKNOWN_ERROR
        $OHMD_S_USER_RESERVED
        $OHMD_VENDOR
    )],
    functions => [qw(
        ohmd_ctx_create
        ohmd_ctx_destroy
        ohmd_ctx_get_error
        ohmd_ctx_probe
        ohmd_list_gets
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

sub ohmd_ctx_get_error {
    croak 'Too few arguments'  if scalar @_ < 1;
    croak 'Too many arguments' if scalar @_ > 1;

    return _inline_ohmd_ctx_get_error(@_);
}

sub ohmd_ctx_probe {
    croak 'Too few arguments'  if scalar @_ < 1;
    croak 'Too many arguments' if scalar @_ > 1;

    return _inline_ohmd_ctx_probe(@_);
}

sub ohmd_list_gets {
    croak 'Too few arguments'  if scalar @_ < 3;
    croak 'Too many arguments' if scalar @_ > 3;

    return _inline_ohmd_list_gets(@_);
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

char * _inline_ohmd_ctx_get_error(int ctx) {
    return ohmd_ctx_get_error(ctx);
}

int _inline_ohmd_ctx_probe(int ctx) {
    return ohmd_ctx_probe(ctx);
}

char * _inline_ohmd_list_gets(int ctx, int index, int type) {
    return ohmd_list_gets(ctx, index, type);
}
