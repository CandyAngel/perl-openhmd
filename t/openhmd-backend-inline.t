#!/usr/bin/env perl

use strict;
use warnings;

use Test::Exception;
use Test::More;

use OpenHMD::Backend::Inline qw(:all);

my $CONTEXT;

subtest 'functions' => sub {
    my @functions = qw(
        ohmd_ctx_create
        ohmd_ctx_destroy
    );
    push @functions, map { '_inline_' . $_ } @functions;

    foreach my $function (@functions) {
        can_ok 'OpenHMD::Backend::Inline', $function;
    }
};

subtest 'ohmd_ctx_create' => sub {
    throws_ok { ohmd_ctx_create(1) } qr/^Too many arguments/,
        'Too many arguments';

    $CONTEXT = ohmd_ctx_create();
    cmp_ok $CONTEXT, '>', 0, 'Valid context handle';
};

subtest 'ohmd_ctx_destroy' => sub {
    throws_ok { ohmd_ctx_destroy() } qr/^Too few arguments/,
        'Too few arguments';
    throws_ok { ohmd_ctx_destroy(1, 1) } qr/^Too many arguments/,
        'Too many arguments';

    ohmd_ctx_destroy($CONTEXT);
};

done_testing();
