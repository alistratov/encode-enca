package Encode::Enca;

use 5.008000;
use strict;
use warnings;

#use Carp;
use Exporter;
use AutoLoader;
use XSLoader;

use Encode::Enca::Constants qw(:all);
use Encode::Enca::Surface;
use Encode::Enca::Charset;
use Encode::Enca::Language;
use Encode::Enca::Encoding;

our $VERSION = '0.01';
use base qw(Exporter);

# ------------------------------------------------------------------------------

XSLoader::load('Encode::Enca', $VERSION);

# ------------------------------------------------------------------------------

our $CACHED_LANGUAGES;
our $CACHED_CHARSETS;
our $CACHED_SURFACES;

# ------------------------------------------------------------------------------
sub _create_language($)
{
	my ($class, $id) = @_;
	$id = lc($id);

	if (! $CACHED_LANGUAGES->{$id}) {
		my $params = get_language_properties($id);
		# Invalid language
		return undef if ! $params->{name};

		# Fill supported charsets
		$params->{charsets} = [];
		for my $cid (@{$params->{ncharsets_ids}}) {
			my $c = __PACKAGE__->_create_charset($cid);
			push @{$params->{charsets}}, $c if $c;
		}
		
		$CACHED_LANGUAGES->{$id} = $params;
	}
	return Encode::Enca::Language->new($CACHED_LANGUAGES->{$id});
}
# ------------------------------------------------------------------------------
sub _create_surface($)
{
	my ($class, $id) = @_;

	if (! $CACHED_SURFACES->{$id}) {
		my $params = get_surface_properties($id);
		$CACHED_SURFACES->{$id} = $params;
	}
	return Encode::Enca::Surface->new($CACHED_SURFACES->{$id});
}
# ------------------------------------------------------------------------------
sub _create_charset($)
{
	my ($class, $id) = @_;

	if (! $CACHED_CHARSETS->{$id}) {
		# Unknown charset
		return undef if $id == ENCA_CS_UNKNOWN;

		# Invalid id
		return undef if $id > Encode::Enca::get_number_of_charsets();
		
		my $params = get_charset_properties($id);
		# Invalid charset
		return undef if $params->{flags} == 0;

		$params->{natural_surface} = __PACKAGE__->_create_surface($params->{nsurface_id});
		$CACHED_CHARSETS->{$id} = $params;		
	}
	return Encode::Enca::Charset->new($CACHED_CHARSETS->{$id});
}
# ------------------------------------------------------------------------------
sub _create_encoding(@)
{
	my ($class, $charset_id, $surface_id) = @_;

	my $c = __PACKAGE__->_create_charset($charset_id);
	return undef unless defined $c;

	return Encode::Enca::Encoding->new(
		charset => $c,
		surface => __PACKAGE__->_create_surface($surface_id),
	);
}
# ------------------------------------------------------------------------------
sub languages()
{
	my ($class) = @_;
	
	my @lang_list = ();
	my $ids = Encode::Enca::get_list_of_languages();
	for my $lang_id (@$ids) {
		my $obj = __PACKAGE__->_create_language($lang_id);
		push @lang_list, $obj if $obj;
	}
	return @lang_list;
}
# ------------------------------------------------------------------------------
sub charsets()
{
	my ($class) = @_;
	
	my @charsets_list = ();
	my $nc = Encode::Enca::get_number_of_charsets();
	for (my $id  = 0; $id < $nc; $id++) {
		my $obj = __PACKAGE__->_create_charset($id);
		push @charsets_list, $obj if $obj;
	}
	return @charsets_list;
}
# ------------------------------------------------------------------------------
sub find_encoding_by_name($)
{
	my ($class, $name) = @_;
	
	my ($c, $s) = Encode::Enca::parse_encoding_by_name($name);
	return __PACKAGE__->_create_encoding($c, $s);	
}
# ------------------------------------------------------------------------------

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Encode::Enca - Perl extension for libenca

=head1 SYNOPSIS

  use Encode::Enca;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Encode::Enca.

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Oleg Alistratov, E<lt>wmute@yandex-team.ru<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Oleg Alistratov

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
