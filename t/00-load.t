#!perl -T
use 5.10.1;
use strict;
use warnings;
use Test::More;

plan tests => 2;

BEGIN {
    use_ok( 'Net::ServicePinger::Server' ) || print "Bail out!\n";
    use_ok( 'Net::ServicePinger::Client' ) || print "Bail out!\n";
}

diag( "Testing Net::ServicePinger::Server $Net::ServicePinger::Server::VERSION, Perl $], $^X" );
