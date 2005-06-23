#!perl
# $Id$
#
# Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

use strict;
use Module::Build;

my $build = Module::Build->new(
    module_name => 'Tie::Senna',
    requires => {
        'Senna'     => '>= 0.06',
        'Tie::Hash' => 0,
    },
    license => 'perl',
    create_makefile_pl => 'traditional',
);
$build->create_build_script;