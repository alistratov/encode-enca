package Encode::Enca::base;

use 5.008000;
use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.01';

# ------------------------------------------------------------------------------
sub new(;@)
{
    my $class = shift;
    my $self = bless
        @_ ? (@_ > 1 ? {@_} : {%{$_[0]}}) : {},
        ref $class || $class;
    $self->_init;
    return $self;
}
# ------------------------------------------------------------------------------
sub _init()
{
    # Nothing to do in the base class
}
# ------------------------------------------------------------------------------
sub _make_getter
{
	my ($class, $attrs) = @_;
	$attrs = ref($attrs) eq 'ARRAY' ? $attrs : [$attrs];
	
	no strict 'refs';
	use warnings 'redefine';
	
	for my $attr (@$attrs) {
		my $code = "sub { return \$_[0]->{'$attr'} };";
		
		##print("DEBUG MEMBER CODE: $class->$attr\n$code\n\n");

		*{"${class}::$attr"} = eval qq{ $code };
		croak("Compilation failed, code: \n$code\n$@") if $@;
	}
}
# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Encode::Enca::base

=cut
