use 5.10.1;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Net::ServicePinger::Server',
    AUTHOR           => q{John D Jones III <jnbek@cpan.org>},
    VERSION_FROM     => 'lib/Net/ServicePinger/Server.pm',
    ABSTRACT_FROM    => 'lib/Net/ServicePinger/Server.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.10.1,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Net::ServicePinger-*' },
);
