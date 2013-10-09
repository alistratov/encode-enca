use 5.008000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Encode::Enca',
    VERSION_FROM      => 'lib/Encode/Enca.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Encode/Enca.pm', # retrieve abstract from module
    AUTHOR            => 'Oleg Alistratov <zero@cpan.org>',
    PMLIBDIRS         => [ qw(lib Enca) ],
    LIBS              => ['-lenca'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (
	qw(ENCA_CS_UNKNOWN ENCA_NOT_A_CHAR),
	{name=>"ENCA_CHARSET_16BIT", macro=>"1"},
	{name=>"ENCA_CHARSET_32BIT", macro=>"1"},
	{name=>"ENCA_CHARSET_7BIT", macro=>"1"},
	{name=>"ENCA_CHARSET_8BIT", macro=>"1"},
	{name=>"ENCA_CHARSET_BINARY", macro=>"1"},
	{name=>"ENCA_CHARSET_FIXED", macro=>"1"},
	{name=>"ENCA_CHARSET_MULTIBYTE", macro=>"1"},
	{name=>"ENCA_CHARSET_REGULAR", macro=>"1"},
	{name=>"ENCA_CHARSET_VARIABLE", macro=>"1"},
	{name=>"ENCA_EEMPTY", macro=>"1"},
	{name=>"ENCA_EFILTERED", macro=>"1"},
	{name=>"ENCA_EGARBAGE", macro=>"1"},
	{name=>"ENCA_EINVALUE", macro=>"1"},
	{name=>"ENCA_ENOCS8", macro=>"1"},
	{name=>"ENCA_EOK", macro=>"1"},
	{name=>"ENCA_ESIGNIF", macro=>"1"},
	{name=>"ENCA_EWINNER", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_CSTOCS", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_ENCA", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_HUMAN", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_ICONV", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_MIME", macro=>"1"},
	{name=>"ENCA_NAME_STYLE_RFC1345", macro=>"1"},
	{name=>"ENCA_SURFACE_EOL_BIN", macro=>"1"},
	{name=>"ENCA_SURFACE_EOL_CR", macro=>"1"},
	{name=>"ENCA_SURFACE_EOL_CRLF", macro=>"1"},
	{name=>"ENCA_SURFACE_EOL_LF", macro=>"1"},
	{name=>"ENCA_SURFACE_EOL_MIX", macro=>"1"},
	{name=>"ENCA_SURFACE_MASK_ALL", macro=>"1"},
	{name=>"ENCA_SURFACE_MASK_EOL", macro=>"1"},
	{name=>"ENCA_SURFACE_MASK_PERM", macro=>"1"},
	{name=>"ENCA_SURFACE_PERM_21", macro=>"1"},
	{name=>"ENCA_SURFACE_PERM_4321", macro=>"1"},
	{name=>"ENCA_SURFACE_PERM_MIX", macro=>"1"},
	{name=>"ENCA_SURFACE_QP", macro=>"1"},
	{name=>"ENCA_SURFACE_REMOVE", macro=>"1"},
	{name=>"ENCA_SURFACE_UNKNOWN", macro=>"1"}
    );
    ExtUtils::Constant::WriteConstants(
	NAME         => 'Encode::Enca',
	NAMES        => \@names,
	DEFAULT_TYPE => 'IV',
	C_FILE       => 'const-c.inc',
	XS_FILE      => 'const-xs.inc',
    );
}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
