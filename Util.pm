# $Id: Util.pm,v 1.4 2003/03/16 18:03:44 philip Exp $
# $Name:  $

package Time::Util;
use strict;
use warnings FATAL => 'all';
use Carp;

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  @hours
  @mins
  @secs
  @ampms
);

our $VERSION = do { my @r = (q$Revision: 1.4 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

our @hours       = (12);
our @hours2      = (1 .. 11);
push (@hours, @hours2);

our @mins  = ('00' .. '09');
our @mins2 = (10 .. 59);
push (@mins, @mins2);

our @secs  = ('00' .. '09');
our @secs2 = (10 .. 59);
push (@secs, @secs2);

our @ampms = ();
@ampms = qw (A.M. P.M.);

1;
__END__
=head1 NAME

Time::Util - Things used across Time:: Modules

=head1 SYNOPSIS

  Don't use this yourself

=head2 EXPORT
   
=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>   

=head1 COPYRIGHT AND LICENSE   

Copyright 2003 by Philip M. Gollucci
   
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Util.pm,v $
 Revision 1.4  2003/03/16 18:03:44  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.3  2003/03/16 17:59:37  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.2  2003/03/16 17:53:03  philip
 s/<gt>/E<gt>/g;
 Bug in h2xs generation doc stub

 Revision 1.1  2003/03/16 16:39:43  philip
 Added hours, minutes, secs, ampm arrays

=cut

