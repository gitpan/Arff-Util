use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Arff::Util',
    AUTHOR              => 'Ehsan Emadzadeh <ehsan0emadzadeh@yahoo.com>',
    VERSION_FROM        => 'lib/Arff/Util.pm',
    ABSTRACT_FROM       => 'lib/Arff/Util.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Arff-Util-*' },
);
