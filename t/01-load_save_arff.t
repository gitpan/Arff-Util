#!perl -T

use Test::More tests => 12;
use Data::Dumper;
use Arff::Util;

	my $test_buffer =  {
		attributes => [
				{
					attribute_name => "test_attribute",
					attribute_type => "numeric",
				}
			      ],
		records    => [
				{
					test_attribute => 12,
				}
			      ]
	      };
	my $arff_object = Arff::Util->new(debug_mode => 1);
	ok($arff_object, "object created");
	$arff_object->save_arff($test_buffer, "t/test.arff");

	my $loaded_arff = $arff_object->load_arff("t/test.arff");

	ok($loaded_arff, "couldn't load buffer from file".Dumper($loaded_arff));
	ok($loaded_arff->{attributes});
	ok($loaded_arff->{records});
	ok($loaded_arff->{data_record_count});
	ok($loaded_arff->{data_record_count} == 1);
	ok($loaded_arff->{attribute_count} == 1);

	ok($loaded_arff->{records}->[0]);
	ok($loaded_arff->{attributes}->[0]);

	ok($loaded_arff->{records}->[0]->{test_attribute} == 12);
	ok($loaded_arff->{attributes}->[0]->{attribute_name} eq "test_attribute");
	ok($loaded_arff->{attributes}->[0]->{attribute_type} eq "numeric");

