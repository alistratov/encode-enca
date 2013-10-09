package Encode::Enca::Analyzer;

use 5.008000;
use strict;
use warnings;

use Scalar::Util qw(blessed);

use Encode::Enca;
use Encode::Enca::Constants;
use Encode::Enca::base;

our $VERSION = '0.01';
use base qw(Encode::Enca::base);

# ------------------------------------------------------------------------------
__PACKAGE__->_make_getter([ qw(
	language
) ]);

#__PACKAGE__->_make_getter(['id', 'english_name']);
#
    #my $an = Encode::Enca::_create_analyzer('ru');
    #my $sample = 'Хуябрики Хуябрики Хуябрики Хуябрики Хуябрики Хуябрики Хуябрики Хуябрики Хуябрики';
    #my @res = Encode::Enca::_analyze($an, $sample);
    #say Dumper(\@res);
    #@res = Encode::Enca::_analyzer_error($an); # pair (errno, errmsg)
    #say "Error: " . Dumper(\@res);
    #Encode::Enca::_delete_analyzer($an);
# ------------------------------------------------------------------------------
sub _init()
{
    my $self = shift;
    $self->SUPER::_init();
    
    my $lang_is_obj = blessed($self->{language});
    if (! $lang_is_obj || $lang_is_obj ne 'Encode::Enca::Language') {
	$self->{language} = Encode::Enca->_create_language($self->{language});
    }

    die Encode::Enca::Constants::ERRMSG_UNKNOWN_LANGUAGE unless $self->{language};
    
    $self->{_P} = Encode::Enca::create_analyzer(
	$self->{language}->{id},
	$self->{multibyte},
	$self->{interpreted_surfaces},
	$self->{ambiguity},
	$self->{filtering},
	$self->{garbage_test},
	$self->{termination_strictness},
	$self->{significant},
	$self->{threshold},
    );
    die unless $self->{_P};
}
# ------------------------------------------------------------------------------
sub analyze($)
{
	my ($self, $str) = @_;
	my $e = Encode::Enca->_create_encoding(Encode::Enca::analyze($self->{_P}, $str));
	return $e;
}
# ------------------------------------------------------------------------------
sub errno()
{
	my $self = shift;
	return Encode::Enca::analyzer_error_errno($self->{_P});
}
# ------------------------------------------------------------------------------
sub errmsg()
{
	my $self = shift;
	return Encode::Enca::analyzer_error_errmsg($self->{_P});
}
# ------------------------------------------------------------------------------
sub DESTROY
{
	my $self = shift;
	if ($self->{_P}) {
		Encode::Enca::delete_analyzer($self->{_P});
	}
}
# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Encode::Enca::Analyzer

=cut
