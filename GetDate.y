%{
;##############################################################################
;## GetDate.y
;##
;## Copyright (c) 1995 Graham Barr <Graham.Barr@tiuk.ti.com>. All rights
;## reserved. This program is free software; you can redistribute it and/or
;## modify it under the same terms as Perl itself.
;##
;## Attempt to parse a date in any given format.
;##
;## Currently it ignores any token found that it cannot undestand.
;##
;## The yacc source can be found at the end of this file
;##
;## compile with
;##   byacc -P -b strtotime strtotime.y
;##   mv strtotime.tab.pl strtotime.pm
;##   cat strtotime.y >> strtotime.pm
;##############################################################################

#print $yysccsid if defined $print_yysccsid_string;
$yysccsid = $yysccsid; # keep -w quiet

package Date::GetDate;

use Time::Local;
require 5.000;
require Exporter;
@ISA = (Exporter);

$VERSION = sprintf("%d.%02d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/);
sub Version { $VERSION }

@EXPORT = qw( &strtotime );

sub yyerror { $error = 1; }

%}

%token NUM MONTH AM PM ZONE

%%

date: day time year
    | day year time
    | time day year
    | time day
    | day time
    | day year
    | day
    | time
    ;

day: NUM MONTH			{ $month = $2 % 12; $day = $1; }
   | NUM '/' MONTH		{ $month = $3 % 12; $day = $1; }
   | MONTH NUM			{ $month = $1 % 12; $day = $2; }
   | NUM '/' NUM		{ $month = $1 % 12; $day = $3; }
   | NUM '-' MONTH		{ $month = $3 % 12; $day = $1; }
   ;

year: '/' NUM			{ $year = $2 % 100; }
    | '-' NUM			{ $year = $2 % 100; }
    | NUM			{ $year = $1 % 100; }
    ;

time: clock AM			{ $hour %= 12; }
    | clock PM			{ $hour  = ($hour % 12) + 12; }
    | clock
    | ':' clock  
    | time zone
    ;

zone : '+' NUM                  { $delta =  (($2/100)*60 + $2 % 100); }
     | '-' NUM                  { $delta = -(($2/100)*60 + $2 % 100); }
     | ZONE
     ;

clock: NUM ':' NUM ':' NUM	{ $hour = $1 % 24; $min = $3 % 60; $sec = $5 % 60; }
     | NUM ':' NUM		{ $hour = $1 % 24; $min = $3 % 60; }
     ;

%%

sub numqw { local($i,@me,$_); $i = shift @_; foreach (@_) {push @me,$_,$i++} @me  }

%months = numqw(0,qw(jan feb mar apr may jun jul aug sep oct nov dec));

%zone   = ("gmt",  0 * 60,  "bst",  1 * 60,  "est", -5 * 60,  "edt", -6 * 60,
           "cst", -6 * 60,  "cdt", -7 * 60,  "mst", -7 * 60,  "mdt", -8 * 60,
           "pst", -8 * 60,  "pdt", -9 * 60
          ) ;

sub yylex
{
YYLEX: while($string ne '')
  {
   if($string =~ s/\A\s*(\d+)\s*//)
    {
     $yylval = $1;
     return $NUM;
    }
#  elsif($string =~ s/\A\s*([\-\+](\d)?\d)(\d\d)\s*// && $1 >= -12 && $1 <= 12)
#   {
#    $delta -= ($1 * 60) + $3 unless $delta;
#    next YYLEX;
#   }
   elsif($string =~ s/\A\s*([a-z]+)\s*//i)
    {
     local $mon = $1;
     local $key;

     foreach $key (keys %months)
      {
       next unless($mon =~ /\A$key/);
       $yylval = $months{$key};
       return $MONTH;
      }

     foreach $key (keys %zone)
      {
       next unless($mon =~ /\A$key/);
       $yyval = $delta = $zone{$key} unless $delta;
       return $ZONE;
      }

     return $PM if $mon =~ /^p\.?m\.?$/;
     return $AM if $mon =~ /^a\.?m\.?$/;
    }
   elsif($string =~ s/\A\s*([:\-\+\/])\s*//)
    {
     return ord($1);
    }
   else
    {
     $string =~ s/\A\s*\S*\s*//;
    }
  }
 return -1;
}

sub strtotime
{
 local $_;

 ($sec,$min,$hour,$day,$month,$year) = localtime(time);

 $delta  = 0;
 $error  = 0;
 ($string = lc shift) =~ s/\A\s*//;

 yyparse();

 return 0 if($error);

 $time = timegm($sec,$min,$hour,$day,$month,$year);

 $time -= ($delta * 60);

 return $time;
}

__END__

