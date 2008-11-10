#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Arff::Util' );
}

diag( "Testing Arff::Util $Arff::Util::VERSION, Perl $], $^X" );
