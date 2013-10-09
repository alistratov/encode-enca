package Encode::Enca::Charset;

use 5.008000;
use strict;
use warnings;

use Encode::Enca::base;
use Encode::Enca::Constants qw(:charset_properties);

our $VERSION = '0.01';
use base qw(Encode::Enca::base);

# ------------------------------------------------------------------------------
__PACKAGE__->_make_getter([ qw(
	id
	natural_surface
	has_ucs2_map
	name_enca
	name_rfc1345
	name_cstocs
	name_iconv
	name_human
	name_mime
	aliases
) ]);
# ------------------------------------------------------------------------------
sub is_7bit()		{ return shift->{flags} & ENCA_CHARSET_7BIT; }
sub is_8bit()		{ return shift->{flags} & ENCA_CHARSET_8BIT; }
sub is_16bit()		{ return shift->{flags} & ENCA_CHARSET_16BIT; }
sub is_32bit()		{ return shift->{flags} & ENCA_CHARSET_32BIT; }
sub is_fixed()		{ return shift->{flags} & ENCA_CHARSET_FIXED; }
sub is_variable()	{ return shift->{flags} & ENCA_CHARSET_VARIABLE; }
sub is_binary()		{ return shift->{flags} & ENCA_CHARSET_BINARY; }
sub is_regular()	{ return shift->{flags} & ENCA_CHARSET_REGULAR; }
sub is_multibyte()	{ return shift->{flags} & ENCA_CHARSET_MULTIBYTE; }
# ------------------------------------------------------------------------------
#	

# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Encode::Enca::Charset

 Charset naming styles and conventions.

ENCA_NAME_STYLE_ENCA
	Default, implicit charset name in Enca.

ENCA_NAME_STYLE_RFC1345
	RFC 1345 or otherwise canonical charset name.

ENCA_NAME_STYLE_CSTOCS
	Cstocs charset name (may not exist).

ENCA_NAME_STYLE_ICONV
	Iconv charset name (may not exist).

ENCA_NAME_STYLE_HUMAN
	Human comprehensible description.

ENCA_NAME_STYLE_MIME
	Preferred MIME name (may not exist). 

#
#enum EncaCharsetFlags
#
#typedef enum { /*< flags >*/
#  ENCA_CHARSET_7BIT      = 1 << 0,
#  ENCA_CHARSET_8BIT      = 1 << 1,
#  ENCA_CHARSET_16BIT     = 1 << 2,
#  ENCA_CHARSET_32BIT     = 1 << 3,
#  ENCA_CHARSET_FIXED     = 1 << 4,
#  ENCA_CHARSET_VARIABLE  = 1 << 5,
#  ENCA_CHARSET_BINARY    = 1 << 6,
#  ENCA_CHARSET_REGULAR   = 1 << 7,
#  ENCA_CHARSET_MULTIBYTE = 1 << 8
#} EncaCharsetFlags;
#
#Charset properties.
#
#Flags ENCA_CHARSET_7BIT, ENCA_CHARSET_8BIT, ENCA_CHARSET_16BIT, ENCA_CHARSET_32BIT tell how many bits a `fundamental piece' consists of. This is different from bits per character; r.g. UTF-8 consists of 8bit pieces (bytes), but character can be composed from 1 to 6 of them.
#
#ENCA_CHARSET_7BIT
#	Characters are represented with 7bit characters.
#
#ENCA_CHARSET_8BIT
#	Characters are represented with bytes.
#
#ENCA_CHARSET_16BIT
#	Characters are represented with 2byte words.
#
#ENCA_CHARSET_32BIT
#	Characters are represented with 4byte words.
#
#ENCA_CHARSET_FIXED
#	One characters consists of one fundamental piece.
#
#ENCA_CHARSET_VARIABLE
#	One character consists of variable number of fundamental pieces.
#
#ENCA_CHARSET_BINARY
#	Charset is binary from ASCII viewpoint.
#
#ENCA_CHARSET_REGULAR
#	Language dependent (8bit) charset.
#
#ENCA_CHARSET_MULTIBYTE
#	Multibyte charset.

=cut
