use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Arff::Util',
    AUTHOR              => 'Ehsan Emadzadeh <eemadzadeh@gmail.com>',
    VERSION_FROM        => 'lib/Arff/Util.pm',
    ABSTRACT_FROM       => 'lib/Arff/Util.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Data::Dumper' => 2.121_14,
        'Moose' => 0.92,
        'String::Util' => 0.11,
        'Devel::Size' => 0.71,
	'Text::CSV' => 0.01,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Arff-Util-*' },
);
