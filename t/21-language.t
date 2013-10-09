#!/usr/bin/perl -w
 
# ------------------------------------------------------------------------------
use strict;
use warnings;
use utf8;

use Test::More tests => 2;

BEGIN {
	use_ok('Encode::Enca::Language');
	isa_ok('Encode::Enca::Language', 'Encode::Enca::base');
};

&main();
# ------------------------------------------------------------------------------
sub main
{
    #my $lang = Encode::Enca::Language->new(id => 'ru', name => 'russian');
    #print "[x1] ", $lang->id, "\n";
    #print "[x2] ", $lang->name, "\n";
}
# ------------------------------------------------------------------------------
1;
