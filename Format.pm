# $Id: Format.pm,v 1.5 2003/03/16 18:03:44 philip Exp $
# $Name:  $

package Time::Format;
use strict;
use warnings FATAL => 'all';
use Carp;

use Util::Misc;

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  time_format
);

our $VERSION = do { my @r = (q$Revision: 1.5 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

sub time_format ($$) {

  my ($time, $mask) = @_;
  my ($hour, $min, $sec, $ampm);

  ### 1 and exactly 1 regex for each format we support
  
  ## As returned by time_get()
  ## [9 5 40 P.M.] 
  if ($time =~ /(\d{1,2})\s(\d{1,2})\s(\d{1,2})\s(A\.M\.|P\.M\.)/o) {
    ($hour, $min, $sec, $ampm) = ($1, $2, $3, $4);
  }
  ## As returned by MySQL
  ## [09:05:40]
  elsif ($time =~ /(\d{2})\:(\d{2}):(\d{2})/o) {
    ($hour, $min, $sec) = ($1, $2, $3);
    $ampm = "A.M.";
    $ampm = "P.M." if $hour > 12;
    $hour -= 12    if $hour > 12;
  }
  else {
    confess("$time is an unsupported format");
    return undef;
  }
  my $hour24 = $hour;
  $hour24 += 12 if $ampm =~ /P\.M\./;

  ### Create variables used in masks
  my $hh12		= $hour		;
  my $hh12_2		= $hour		;
  my $hh24		= $hour24 	;
  my $hh24_2		= $hour24	;
  my $mi		= $min		;
  my $mi_2		= $min		;
  my $ss		= $sec		;
  my $ss_2		= $sec		;
  my $ampm_l_wo_d	= lc $ampm 	;
  my $ampm_l_w_d	= lc $ampm	;
  my $ampm_c_wo_d	= $ampm		;
  my $ampm_c_w_d	= $ampm		;
  
  $ampm_l_wo_d =~ s/\.//g;
  $ampm_c_wo_d =~ s/\.//g;

  $hh12_2 = &pad($hh12_2, 2, '0', 'front');
  $hh24_2 = &pad($hh24_2, 2, '0', 'front');
  $mi_2   = &pad($mi_2,   2, '0', 'front');
  $ss_2   = &pad($ss_2,   2, '0', 'front');
 
  ### Replace the masks with there values leaving anything else untouched
  $mask =~ s/hh12_2/$hh12_2/g;
  $mask =~ s/hh12/$hh12/g; 
  $mask =~ s/hh24_2/$hh24_2/g;
  $mask =~ s/hh24/$hh24/g;
  $mask =~ s/mi_2/$mi_2/g;
  $mask =~ s/mi/$mi/g;
  $mask =~ s/ss_2/$ss_2/g;
  $mask =~ s/ss/$ss/g;
  $mask =~ s/ampm_l_wo_d/$ampm_l_wo_d/g;
  $mask =~ s/ampm_l_w_d/$ampm_l_w_d/g;
  $mask =~ s/ampm_c_wo_d/$ampm_c_wo_d/g;
  $mask =~ s/ampm_c_w_d/$ampm_c_w_d/g;

  return $mask;
}

1;
__END__
=head1 NAME
    
Time::Format - Format a Time 
    
=head1 SYNOPSIS   
    
  use Time::Format;
  use Time::Current;
  my $timef = &time_format(&time_get(), "hh12:mi:ss ampm");
 
=head2 EXPORT
  time_format();

=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Philip M. Gollucci

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Format.pm,v $
 Revision 1.5  2003/03/16 18:03:44  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.4  2003/03/16 17:59:37  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.3  2003/03/16 05:36:06  philip
 Commented out AUTOLOADER since I'm not using it.
 Moved _2 masks before their counter parts.
 Fixe DateTime::Format.

 Revision 1.2  2003/03/15 13:23:15  philip
 Add in leading 0 padding of _2 fields.

 Revision 1.1.1.1  2003/03/15 11:47:54  philip
 Imported Sources

=cut
