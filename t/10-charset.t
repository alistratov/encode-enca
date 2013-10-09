#!/usr/bin/perl -w
 
# ------------------------------------------------------------------------------
use strict;
use warnings;
use utf8;

use Test::More tests => 25;

use Encode::Enca;

&main();
# ------------------------------------------------------------------------------
sub main
{
    my @cs = Encode::Enca->charsets();
    ok(scalar @cs > 0, 'Charsets');

    
    my $enc_cp1251 = Encode::Enca->find_encoding_by_name('cp1251');
    isa_ok($enc_cp1251, 'Encode::Enca::Encoding');
    
    my $c_cp1251 = $enc_cp1251->charset;
    isa_ok($c_cp1251, 'Encode::Enca::Charset');
    is($c_cp1251->name_mime, 	'windows-1251', 	'name1');
    is($c_cp1251->name_rfc1345, 'CP1251', 		'name2');

    ok(! $c_cp1251->is_7bit, 		'7bit');
    ok($c_cp1251->is_8bit,		'8bit');
    ok(! $c_cp1251->is_16bit, 		'16bit');
    ok(! $c_cp1251->is_32bit,		'32bit');
    ok($c_cp1251->is_fixed,		'fixed');
    ok(! $c_cp1251->is_variable,	'variable');
    ok(! $c_cp1251->is_binary,		'binary');
    ok($c_cp1251->is_regular,		'regular');
    ok(! $c_cp1251->is_multibyte,	'multibyte');

    my $enc_utf8 = Encode::Enca->find_encoding_by_name('utf8');
    my $c_utf8 = $enc_utf8->charset;
    is($c_utf8->name_mime, 	'UTF-8', 		'name3');
    is($c_utf8->name_rfc1345, 	'UTF-8', 		'name4');
    
    ok(! $c_utf8->is_7bit, 		'7bit');
    ok($c_utf8->is_8bit,		'8bit');
    ok(! $c_utf8->is_16bit, 		'16bit');
    ok(! $c_utf8->is_32bit,		'32bit');
    ok(! $c_utf8->is_fixed,		'fixed');
    ok($c_utf8->is_variable,		'variable');
    ok(! $c_utf8->is_binary,		'binary');
    ok(! $c_utf8->is_regular,		'regular');
    ok($c_utf8->is_multibyte,		'multibyte');
}
# ------------------------------------------------------------------------------
1;
