#!/usr/bin/perl -w
# coding: UTF-8

# ------------------------------------------------------------------------------
# http://www.lottery.com.ua/pages/results/loto.php
# ------------------------------------------------------------------------------

use common::sense;
use Data::Dumper;

# ------------------------------------------------------------------------------
&main();
# ------------------------------------------------------------------------------
sub main
{
    my $src = {
	'ru'	=> {
	    'strings'	=> [
		'Хуй',
		'Широкая электрификация южных губерний даст мощный толчок подъёму сельского хозяйства.',
		'Спасибо, князь. Вы настоящий дворянин. И программист.',
		'Были демоны, — мы этого не отрицаем. Но они самоликвидировались. Так что прошу эту глупую панику прекратить!',
		'Бамбарбия! Киргуду!',
	    ],
	    'encodings'	=> [
	    ],
	},
    };
}
# ------------------------------------------------------------------------------
1;
