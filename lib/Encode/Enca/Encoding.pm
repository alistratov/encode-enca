package Encode::Enca::Encoding;

use 5.008000;
use strict;
use warnings;

use Encode::Enca::base;

our $VERSION = '0.01';
use base qw(Encode::Enca::base);

# ------------------------------------------------------------------------------
__PACKAGE__->_make_getter([ qw(
	charset
	surface
) ]);
# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Encode::Enca::Encoding

=cut
