# $Id: Current.pm,v 1.5 2003/03/16 18:03:44 philip Exp $
# $Name:  $

package Time::Current;
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
  time_get
);

our $VERSION = do { my @r = (q$Revision: 1.5 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

sub time_get {

  my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdist) = localtime();

  my $ampm = "A.M.";
  $ampm = "P.M." if $hour >= 12;
  $hour -= 12 if $hour > 12;

  if (wantarray) {
    return ($hour, $min, $sec, $ampm);
  }
  else {
    return "$hour $min $sec $ampm";
  }
}

1;
__END__
=head1 NAME

Time::Current - Time Date

=head1 SYNOPSIS

  use Time::Current;
  my ($hour, $min, $sec, $ampm, $isdist) = &time_get();
  my $now_string = &time_get();

=head2 EXPORT
  time_get();

=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Philip M. Gollucci

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Current.pm,v $
 Revision 1.5  2003/03/16 18:03:44  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.4  2003/03/16 17:59:37  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.3  2003/03/16 17:53:02  philip
 s/<gt>/E<gt>/g;
 Bug in h2xs generation doc stub

 Revision 1.2  2003/03/16 05:36:06  philip
 Commented out AUTOLOADER since I'm not using it.
 Moved _2 masks before their counter parts.
 Fixe DateTime::Format.

 Revision 1.1.1.1  2003/03/15 11:47:54  philip
 Imported Sources

=cut
