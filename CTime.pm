#
# Modified from ctimp.pl
# All Modifications (c) Copyright Graham Barr <Graham.Barr@tiuk.ti.com>
#
# Changed package name to Date::CTime
# Allowed timezone to be passed in as second arg
# Added code to modify timezone if the DST of the time passed in
#   is not the same as the current DST
#
# ctime.pl is a simple Perl emulation for the well known ctime(3C) function.
#
# Waldemar Kebsch, Federal Republic of Germany, November 1988
# kebsch.pad@nixpbe.UUCP
# Modified March 1990, Feb 1991 to properly handle timezones
#  $RCSfile: CTime.pm,v $$Revision: 1.1 $$Date: 1995/02/08 10:12:58 $
#   Marion Hakanson (hakanson@cse.ogi.edu)
#   Oregon Graduate Institute of Science and Technology
#
# usage:
#
#     #include <ctime.pl>          # see the -P and -I option in perl.man
#     $Date = &ctime(time);

package Date::CTime;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw( ctime );

$VERSION = sprintf("%d.%02d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/);
sub Version { $VERSION }

BEGIN {
    @DoW = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
    @MoY = ('Jan','Feb','Mar','Apr','May','Jun',
	    'Jul','Aug','Sep','Oct','Nov','Dec');
}

sub ctime {
    local($time,$TZ) = @_;
    local($[) = 0;
    local($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);

    # Determine what time zone is in effect.
    # Use GMT if TZ is defined as null, local time if TZ undefined.
    # There's no portable way to find the system default timezone.
    
    $TZ = defined($ENV{'TZ'}) ? ( $ENV{'TZ'} ? $ENV{'TZ'} : 'GMT' ) : ''
        unless(defined $TZ);

    ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
        ($TZ eq 'GMT') ? gmtime($time) : localtime($time);

    #
    # Compensate for times in different DST
    #
    if($TZ ne 'GMT' && $isdst != (localtime(time))[8])
     {
      local($gsec, $gmin, $ghour, $gmday, $gmon, $gyear, $gwday, $gyday) = gmtime($time);
      $gsec = $gsec; $gmon = $gmon; $gmday = $gmday; $gwday = $gwday; # keep -w quiet
      local($l) = (($year * 365 + $yday) * 24 + $hour) * 60 + $min;
      local($g) = (($gyear * 365 + $gyday) * 24 + $ghour) * 60 + $gmin;
      local($d) = $l - $g;

      $TZ = sprintf("%+05d",int($d / 60) * 100 + $d % 60);
     }

    # Hack to deal with 'PST8PDT' format of TZ
    # Note that this can't deal with all the esoteric forms, but it
    # does recognize the most common: [:]STDoff[DST[off][,rule]]

    if($TZ=~/^([^:\d+\-,]{3,})([+-]?\d{1,2}(:\d{1,2}){0,2})([^\d+\-,]{3,})?/){
        $TZ = $isdst ? $4 : $1;
    }
    $TZ .= ' ' unless $TZ eq '';

    $year += 1900;
    sprintf("%s %s %2d %2d:%02d:%02d %s%4d\n",
      $DoW[$wday], $MoY[$mon], $mday, $hour, $min, $sec, $TZ, $year);
}
1;
