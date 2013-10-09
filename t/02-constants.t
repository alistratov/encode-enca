#!/usr/bin/perl -w
 
# ------------------------------------------------------------------------------
use strict;
use warnings;
use utf8;

use Test::More tests => 1;

use Encode::Enca::Constants qw(:all);

&main();
# ------------------------------------------------------------------------------
sub main
{
	my $fail = 0;

	for my $constname (@Encode::Enca::Constants::EXPORT_OK) {
		#print "[-] $constname = ", eval "Encode::Enca::Constants::$constname", "\n";
		next if (eval "my \$a = Encode::Enca::Constants::$constname; 1");
		if ($@ =~ /^Your vendor has not defined Encode::Enca macro $constname/) {
			print "# pass: $@";
		}
		else {
			print "# fail: $@";
			$fail = 1;
		}
	}
	
	ok($fail == 0, 'Constants');
}
# ------------------------------------------------------------------------------
1;
