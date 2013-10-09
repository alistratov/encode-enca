package Encode::Enca::Constants;

use 5.008000;
use strict;
use warnings;

use Carp qw(croak);
use Exporter;
use AutoLoader;
use XSLoader;

our $VERSION = '0.01';
use base qw(Exporter);

# ------------------------------------------------------------------------------
our @EXPORT = ();
our @EXPORT_OK = ();
our %EXPORT_TAGS = (
	'error_codes' => [qw(
		ENCA_EOK
		ENCA_EINVALUE
		ENCA_EEMPTY
		ENCA_EFILTERED
		ENCA_ENOCS8
		ENCA_ESIGNIF
		ENCA_EWINNER
		ENCA_EGARBAGE
	)],
	
	'name_styles' => [qw(
		ENCA_NAME_STYLE_ENCA
		ENCA_NAME_STYLE_RFC1345
		ENCA_NAME_STYLE_CSTOCS
		ENCA_NAME_STYLE_ICONV
		ENCA_NAME_STYLE_HUMAN
		ENCA_NAME_STYLE_MIME
	)],
	
	'charset_properties' => [qw(
		ENCA_CHARSET_7BIT
		ENCA_CHARSET_8BIT
		ENCA_CHARSET_16BIT
		ENCA_CHARSET_32BIT
		ENCA_CHARSET_FIXED
		ENCA_CHARSET_VARIABLE
		ENCA_CHARSET_BINARY
		ENCA_CHARSET_REGULAR
		ENCA_CHARSET_MULTIBYTE
	)],
		    
	'surface_properties' => [qw(
		ENCA_SURFACE_EOL_CR
		ENCA_SURFACE_EOL_LF
		ENCA_SURFACE_EOL_CRLF
		ENCA_SURFACE_EOL_MIX
		ENCA_SURFACE_EOL_BIN
		ENCA_SURFACE_MASK_EOL
		ENCA_SURFACE_PERM_21
		ENCA_SURFACE_PERM_4321
		ENCA_SURFACE_PERM_MIX
		ENCA_SURFACE_MASK_PERM
		ENCA_SURFACE_QP
		ENCA_SURFACE_REMOVE
		ENCA_SURFACE_UNKNOWN
		ENCA_SURFACE_MASK_ALL
	)],
		    
	'special' => [qw(
		ENCA_NOT_A_CHAR
		ENCA_CS_UNKNOWN
		ERRMSG_UNKNOWN_LANGUAGE
	)],
);
# ------------------------------------------------------------------------------
# Fill @EXPORT_OK and make ":all" tag.
{
    for my $ar (values(%EXPORT_TAGS)) {
        push(@EXPORT_OK, @$ar);
    }
    $EXPORT_TAGS{all} = [ @EXPORT_OK ];
}

# Autoload constants from the constant() XS function.
sub AUTOLOAD {
    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Encode::Enca::constant not defined" if $constname eq 'constant';
    my ($error, $val) = Encode::Enca::constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	*$AUTOLOAD = sub { $val };
    }
    goto &$AUTOLOAD;
}
# ------------------------------------------------------------------------------
# Pure-perl constants
use constant {
	ERRMSG_UNKNOWN_LANGUAGE	=> 'Unknown language',
};

# ------------------------------------------------------------------------------

XSLoader::load('Encode::Enca', $VERSION);

# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Encode::Enca::Constants

=head2 Exportable constants

  ENCA_CHARSET_16BIT
  ENCA_CHARSET_32BIT
  ENCA_CHARSET_7BIT
  ENCA_CHARSET_8BIT
  ENCA_CHARSET_BINARY
  ENCA_CHARSET_FIXED
  ENCA_CHARSET_MULTIBYTE
  ENCA_CHARSET_REGULAR
  ENCA_CHARSET_VARIABLE
  ENCA_CS_UNKNOWN
  ENCA_EEMPTY
  ENCA_EFILTERED
  ENCA_EGARBAGE
  ENCA_EINVALUE
  ENCA_ENOCS8
  ENCA_EOK
  ENCA_ESIGNIF
  ENCA_EWINNER
  ENCA_NAME_STYLE_CSTOCS
  ENCA_NAME_STYLE_ENCA
  ENCA_NAME_STYLE_HUMAN
  ENCA_NAME_STYLE_ICONV
  ENCA_NAME_STYLE_MIME
  ENCA_NAME_STYLE_RFC1345
  ENCA_NOT_A_CHAR
  ENCA_SURFACE_EOL_BIN
  ENCA_SURFACE_EOL_CR
  ENCA_SURFACE_EOL_CRLF
  ENCA_SURFACE_EOL_LF
  ENCA_SURFACE_EOL_MIX
  ENCA_SURFACE_MASK_ALL
  ENCA_SURFACE_MASK_EOL
  ENCA_SURFACE_MASK_PERM
  ENCA_SURFACE_PERM_21
  ENCA_SURFACE_PERM_4321
  ENCA_SURFACE_PERM_MIX
  ENCA_SURFACE_QP
  ENCA_SURFACE_REMOVE
  ENCA_SURFACE_UNKNOWN

=cut
