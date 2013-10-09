#!/usr/bin/perl -w
 
# ------------------------------------------------------------------------------
use strict;
use warnings;
use utf8;

use Test::More tests => 7 * 2;

BEGIN {
	use_ok('Encode::Enca');
	isa_ok('Encode::Enca', 'Exporter');

	use_ok('Encode::Enca::Constants');
	isa_ok('Encode::Enca::Constants', 'Exporter');

	use_ok('Encode::Enca::Language');
	isa_ok('Encode::Enca::Language', 'Encode::Enca::base');

	use_ok('Encode::Enca::Charset');
	isa_ok('Encode::Enca::Charset', 'Encode::Enca::base');
	
	use_ok('Encode::Enca::Surface');
	isa_ok('Encode::Enca::Surface', 'Encode::Enca::base');
	
	use_ok('Encode::Enca::Encoding');
	isa_ok('Encode::Enca::Encoding', 'Encode::Enca::base');

	use_ok('Encode::Enca::Analyzer');
	isa_ok('Encode::Enca::Analyzer', 'Encode::Enca::base');
};

&main();
# ------------------------------------------------------------------------------
sub main
{
    #
}
# ------------------------------------------------------------------------------
1;
