package Net::ServicePinger::Client;

use 5.10.1;
use strict;
use warnings;

use Carp;
use Socket;
use HTTP::Tiny;
use Time::HiRes qw(time);

=head1 NAME

Net::ServicePinger::Client - Network Service Pinger for LANs supports HTTP and AJP

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

sub protocol_list { [qw( http ajp )] }

sub new {
    my $proto         = shift;
    my $class         = ref($proto) || $proto;
    my $args          = ref $_[0] eq "HASH" ? shift : {@_};
    my $self          = {};
    my @required_args = qw(protocol ip port);
    my $size          = map {
        if ( $args->{$_} ) { $self->{$_} = $args->{$_}; }
        else               { croak "Required argument $_ was missing" }
    } @required_args;
    bless $self, $class;
    return $self;
}

sub slap {
    my $self = shift;
    croak sprintf( "Protocol %s is not implemented", $self->{'protocol'} )
      unless grep { /$self->{'protocol'}/ } @{ $self->protocol_list };
    my $method = join '_', 'slap', $self->{'protocol'};
    return if $self->$method( $self->{'ip'}, $self->{'port'} );
    return 1;
}

sub slap_http {
    my $self = shift;
    my $host = shift;
    my $port = shift;

}

sub slap_ajp {
    my $self = shift;
    my $host   = shift;
    my $port = shift;
    # The following Stolen Gratuitiously from
    # https://www.joedog.org/2012/06/ajp-functional-test/
    my $iaddr = inet_aton($host) || croak("Unknown host ($host)");
    my $paddr = sockaddr_in( $port, $iaddr ) || croak("Unable to establish a socket address");
    my $proto = getprotobyname('tcp');
    socket( my $sock, PF_INET, SOCK_STREAM, $proto ) || croak "Unable to create a socket.";
    connect( $sock, $paddr ) || croak "Unable to connect to server";
    syswrite $sock, "\x12\x34\x00\x01\x0a";
    sysread $sock, my $recv, 5 || croak "read: $!, stopped";
    my @vals = unpack 'C5', $recv;
    my @acks = qw (65 66 0 1 9);
    my %vals = map { $_, 1 } @vals;
    my @diff = grep { !$vals{$_} } @acks;
    close($sock);

    if ( @diff == 0 ) {
        return;
    }
    else {
        print "Protocol error: unable to verify AJP host $host:$port\n";
        return 1;
    }
}

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Net::ServicePinger::Client;

    my $foo = Net::ServicePinger::Client->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

John D Jones III, C<< <jnbek at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net::servicepinger at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net::ServicePinger>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::ServicePinger::Client


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net::ServicePinger>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net::ServicePinger>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net::ServicePinger>

=item * Search CPAN

L<http://search.cpan.org/dist/Net::ServicePinger/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2015 John D Jones III.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1;    # End of Net::ServicePinger::Client
