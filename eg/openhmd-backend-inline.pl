#!/usr/bin/env perl

use strict;
use warnings;

use OpenHMD::Backend::Inline qw(:all);

my $context = ohmd_ctx_create() or die 'Failed to create context';

ohmd_ctx_destroy($context);
