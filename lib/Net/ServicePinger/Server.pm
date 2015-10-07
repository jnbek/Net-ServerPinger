package Net::ServicePinger::Server;

use 5.10.1;
use strict;
use warnings;

=head1 NAME

Net::ServicePinger::Server - Network Service Pinger for LANs supports HTTP and AJP

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $args  = ref $_[0] eq "HASH" ? shift : {@_};
    my $self  = {};
    $self->{'content_type'} =
      ( $args->{'content_type'} || 0 ) ? $args->{'content_type'} : "text/plain";
    $self->{'response'} = ( $args->{'response'} || 0 ) ? $args->{'response'} : "SUCCESS";
    bless $self, $class;
    return $self;
}

sub serve {
    my $self = shift;
    my $app = sub {
        my $env = shift;
        return [
                 '200',
                 [ 'Content-Type' => $self->{'content_type'} ],
                 [ $self->{'response'} ],
        ];
    };
}

=head1 SYNOPSIS

A VERY simple PSGI application that returns a simple string per request.

Perhaps a little code snippet.

    use Net::ServicePinger::Server;

    my $foo = Net::ServicePinger::Server->new();
    $foo->serve();

returns SUCCESS!!

    use Net::ServicePinger::Server;

    my $foo = Net::ServicePinger::Server->new( 
        content_type => "text/html",
        response => "<h1>This is my response, I hope you like it</h1>",
    );
    $foo->serve();


=head1 SUBROUTINES/METHODS

=head2 new
Takes two hash or hashref arguments:

content_type => "text/html" # Defaults to text/plain
response => "Some text";    # Defaults to SUCCESS

This optional argument will be what is returned to any requests.

=head2 serve
Listens for PSGI requests and returns a string response. 

=head1 AUTHOR

John D Jones III, C<< <jnbek at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net::servicepinger at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net::ServicePinger>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::ServicePinger::Server


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

1; # End of Net::ServicePinger::Server
