$yysccsid = "@(#)yaccpar 1.8 (Berkeley) 01/20/91 (Perl 2.0 12/31/92)";
#define YYBYACC 1
#line 2 "GetDate.y"
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

;#print $yysccsid if defined $print_yysccsid_string;
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

#line 41 "GetDate.tab.pl"
$NUM=257;
$MONTH=258;
$AM=259;
$PM=260;
$ZONE=261;
$YYERRCODE=256;
@yylhs = (                                               -1,
    0,    0,    0,    0,    0,    0,    0,    0,    1,    1,
    1,    1,    1,    3,    3,    3,    2,    2,    2,    2,
    2,    5,    5,    5,    4,    4,
);
@yylen = (                                                2,
    3,    3,    3,    2,    2,    2,    1,    1,    2,    3,
    2,    3,    3,    2,    2,    1,    2,    2,    1,    2,
    2,    2,    2,    1,    5,    3,
);
@yydefred = (                                             0,
    0,    0,    0,    0,    0,    0,    0,    9,    0,    0,
    0,   11,    0,   20,    0,    0,    0,    0,    0,    0,
   24,    0,    0,    0,   21,   17,   18,   12,   10,   13,
    0,   14,   15,   16,    0,    1,    0,   23,   22,    3,
    0,    0,   25,
);
@yydgoto = (                                              4,
    5,    6,   19,    7,   25,
);
@yysindex = (                                           -54,
  -34, -230, -224,    0,  -28,  -43, -234,    0, -226, -235,
 -223,    0,  -23,    0,  -23, -221, -220,  -40,  -37,  -31,
    0, -219, -218,  -27,    0,    0,    0,    0,    0,    0,
  -18,    0,    0,    0, -216,    0,  -33,    0,    0,    0,
 -215,    0,    0,
);
@yyrindex = (                                             0,
    0,    0,    0,    0,   43,   45,    6,    0,    0,    0,
    0,    0,    0,    0,    8,    0,    0,   47,   50,    0,
    0,    0,    0,   55,    0,    0,    0,    0,    0,    0,
    1,    0,    0,    0,    0,    0,   57,    0,    0,    0,
    0,    9,    0,
);
@yygindex = (                                             0,
   52,   10,    4,   56,    0,
);
$YYTABLESIZE=270;
@yytable = (                                             23,
   26,   22,   23,    3,   35,   19,   16,   16,   15,   23,
   10,   22,    9,   10,   18,    9,   17,   17,   16,   16,
    3,   36,   30,   11,   26,   27,   12,   40,   37,    3,
   28,   29,   13,   31,   11,   32,   33,   38,   39,   41,
   42,   43,    7,   26,    8,   26,    5,   26,   19,    6,
   19,   23,   19,   23,    4,   23,    2,   24,   14,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    1,    2,    0,    0,    0,    0,    0,    0,
    0,    0,    0,   20,    2,    0,   34,   21,    0,   13,
   21,    0,    0,    8,    0,    0,    8,   21,   15,   34,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   26,   26,   26,
   26,   26,   19,   19,   16,   23,   19,    0,    0,   23,
);
@yycheck = (                                             43,
    0,   45,   43,   58,   45,    0,   47,    0,    0,   43,
   45,   45,   47,   45,    5,   47,   45,   45,   47,   47,
   58,   18,  258,   58,  259,  260,  257,   24,   19,   58,
  257,  258,  257,  257,   58,  257,  257,  257,  257,   58,
  257,  257,    0,   43,    0,   45,    0,   47,   43,    0,
   45,   43,   47,   45,    0,   47,    0,    6,    3,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,  257,  258,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,  257,  258,   -1,  257,  261,   -1,  257,
  261,   -1,   -1,  258,   -1,   -1,  258,  261,  257,  257,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,  258,  259,
  260,  261,  257,  258,  257,  257,  261,   -1,   -1,  261,
);
$YYFINAL=4;
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
$YYMAXTOKEN=261;
#if YYDEBUG
@yyname = (
"end-of-file",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','',"'+'",'',"'-'",'',"'/'",'','','','','','','','','','',"':'",'','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',"NUM","MONTH",
"AM","PM","ZONE",
);
@yyrule = (
"\$accept : date",
"date : day time year",
"date : day year time",
"date : time day year",
"date : time day",
"date : day time",
"date : day year",
"date : day",
"date : time",
"day : NUM MONTH",
"day : NUM '/' MONTH",
"day : MONTH NUM",
"day : NUM '/' NUM",
"day : NUM '-' MONTH",
"year : '/' NUM",
"year : '-' NUM",
"year : NUM",
"time : clock AM",
"time : clock PM",
"time : clock",
"time : ':' clock",
"time : time zone",
"zone : '+' NUM",
"zone : '-' NUM",
"zone : ZONE",
"clock : NUM ':' NUM ':' NUM",
"clock : NUM ':' NUM",
);
#endif
sub yyclearin { $yychar = -1; }
sub yyerrok { $yyerrflag = 0; }
$YYSTACKSIZE = $YYSTACKSIZE || $YYMAXDEPTH || 500;
$YYMAXDEPTH = $YYMAXDEPTH || $YYSTACKSIZE || 500;
$yyss[$YYSTACKSIZE] = 0;
$yyvs[$YYSTACKSIZE] = 0;
sub YYERROR { ++$yynerrs; &yy_err_recover; }
sub yy_err_recover
{
  if ($yyerrflag < 3)
  {
    $yyerrflag = 3;
    while (1)
    {
      if (($yyn = $yysindex[$yyss[$yyssp]]) && 
          ($yyn += $YYERRCODE) >= 0 && 
          $yycheck[$yyn] == $YYERRCODE)
      {
#if YYDEBUG
       print "yydebug: state $yyss[$yyssp], error recovery shifting",
             " to state $yytable[$yyn]\n" if $yydebug;
#endif
        $yyss[++$yyssp] = $yystate = $yytable[$yyn];
        $yyvs[++$yyvsp] = $yylval;
        next yyloop;
      }
      else
      {
#if YYDEBUG
        print "yydebug: error recovery discarding state ",
              $yyss[$yyssp], "\n"  if $yydebug;
#endif
        return(1) if $yyssp <= 0;
        --$yyssp;
        --$yyvsp;
      }
    }
  }
  else
  {
    return (1) if $yychar == 0;
#if YYDEBUG
    if ($yydebug)
    {
      $yys = '';
      if ($yychar <= $YYMAXTOKEN) { $yys = $yyname[$yychar]; }
      if (!$yys) { $yys = 'illegal-symbol'; }
      print "yydebug: state $yystate, error recovery discards ",
            "token $yychar ($yys)\n";
    }
#endif
    $yychar = -1;
    next yyloop;
  }
0;
} # yy_err_recover

sub yyparse
{
#ifdef YYDEBUG
  if ($yys = $ENV{'YYDEBUG'})
  {
    $yydebug = int($1) if $yys =~ /^(\d)/;
  }
#endif

  $yynerrs = 0;
  $yyerrflag = 0;
  $yychar = (-1);

  $yyssp = 0;
  $yyvsp = 0;
  $yyss[$yyssp] = $yystate = 0;

yyloop: while(1)
  {
    yyreduce: {
      last yyreduce if ($yyn = $yydefred[$yystate]);
      if ($yychar < 0)
      {
        if (($yychar = &yylex) < 0) { $yychar = 0; }
#if YYDEBUG
        if ($yydebug)
        {
          $yys = '';
          if ($yychar <= $#yyname) { $yys = $yyname[$yychar]; }
          if (!$yys) { $yys = 'illegal-symbol'; };
          print "yydebug: state $yystate, reading $yychar ($yys)\n";
        }
#endif
      }
      if (($yyn = $yysindex[$yystate]) && ($yyn += $yychar) >= 0 &&
              $yycheck[$yyn] == $yychar)
      {
#if YYDEBUG
        print "yydebug: state $yystate, shifting to state ",
              $yytable[$yyn], "\n"  if $yydebug;
#endif
        $yyss[++$yyssp] = $yystate = $yytable[$yyn];
        $yyvs[++$yyvsp] = $yylval;
        $yychar = (-1);
        --$yyerrflag if $yyerrflag > 0;
        next yyloop;
      }
      if (($yyn = $yyrindex[$yystate]) && ($yyn += $yychar) >= 0 &&
            $yycheck[$yyn] == $yychar)
      {
        $yyn = $yytable[$yyn];
        last yyreduce;
      }
      if (! $yyerrflag) {
        &yyerror('syntax error');
        ++$yynerrs;
      }
      return(1) if &yy_err_recover;
    } # yyreduce
#if YYDEBUG
    print "yydebug: state $yystate, reducing by rule ",
          "$yyn ($yyrule[$yyn])\n"  if $yydebug;
#endif
    $yym = $yylen[$yyn];
    $yyval = $yyvs[$yyvsp+1-$yym];
    switch:
    {
if ($yyn == 9) {
#line 54 "GetDate.y"
{ $month = $yyvs[$yyvsp-0] % 12; $day = $yyvs[$yyvsp-1]; 
last switch;
} }
if ($yyn == 10) {
#line 55 "GetDate.y"
{ $month = $yyvs[$yyvsp-0] % 12; $day = $yyvs[$yyvsp-2]; 
last switch;
} }
if ($yyn == 11) {
#line 56 "GetDate.y"
{ $month = $yyvs[$yyvsp-1] % 12; $day = $yyvs[$yyvsp-0]; 
last switch;
} }
if ($yyn == 12) {
#line 57 "GetDate.y"
{ $month = $yyvs[$yyvsp-2] % 12; $day = $yyvs[$yyvsp-0]; 
last switch;
} }
if ($yyn == 13) {
#line 58 "GetDate.y"
{ $month = $yyvs[$yyvsp-0] % 12; $day = $yyvs[$yyvsp-2]; 
last switch;
} }
if ($yyn == 14) {
#line 61 "GetDate.y"
{ $year = $yyvs[$yyvsp-0] % 100; 
last switch;
} }
if ($yyn == 15) {
#line 62 "GetDate.y"
{ $year = $yyvs[$yyvsp-0] % 100; 
last switch;
} }
if ($yyn == 16) {
#line 63 "GetDate.y"
{ $year = $yyvs[$yyvsp-0] % 100; 
last switch;
} }
if ($yyn == 17) {
#line 66 "GetDate.y"
{ $hour %= 12; 
last switch;
} }
if ($yyn == 18) {
#line 67 "GetDate.y"
{ $hour  = ($hour % 12) + 12; 
last switch;
} }
if ($yyn == 22) {
#line 73 "GetDate.y"
{ $delta =  (($yyvs[$yyvsp-0]/100)*60 + $yyvs[$yyvsp-0] % 100); 
last switch;
} }
if ($yyn == 23) {
#line 74 "GetDate.y"
{ $delta = -(($yyvs[$yyvsp-0]/100)*60 + $yyvs[$yyvsp-0] % 100); 
last switch;
} }
if ($yyn == 25) {
#line 78 "GetDate.y"
{ $hour = $yyvs[$yyvsp-4] % 24; $min = $yyvs[$yyvsp-2] % 60; $sec = $yyvs[$yyvsp-0] % 60; 
last switch;
} }
if ($yyn == 26) {
#line 79 "GetDate.y"
{ $hour = $yyvs[$yyvsp-2] % 24; $min = $yyvs[$yyvsp-0] % 60; 
last switch;
} }
#line 384 "GetDate.tab.pl"
    } # switch
    $yyssp -= $yym;
    $yystate = $yyss[$yyssp];
    $yyvsp -= $yym;
    $yym = $yylhs[$yyn];
    if ($yystate == 0 && $yym == 0)
    {
#if YYDEBUG
      print "yydebug: after reduction, shifting from state 0 ",
            "to state $YYFINAL\n" if $yydebug;
#endif
      $yystate = $YYFINAL;
      $yyss[++$yyssp] = $YYFINAL;
      $yyvs[++$yyvsp] = $yyval;
      if ($yychar < 0)
      {
        if (($yychar = &yylex) < 0) { $yychar = 0; }
#if YYDEBUG
        if ($yydebug)
        {
          $yys = '';
          if ($yychar <= $#yyname) { $yys = $yyname[$yychar]; }
          if (!$yys) { $yys = 'illegal-symbol'; }
          print "yydebug: state $YYFINAL, reading $yychar ($yys)\n";
        }
#endif
      }
      return(0) if $yychar == 0;
      next yyloop;
    }
    if (($yyn = $yygindex[$yym]) && ($yyn += $yystate) >= 0 &&
        $yyn <= $#yycheck && $yycheck[$yyn] == $yystate)
    {
        $yystate = $yytable[$yyn];
    } else {
        $yystate = $yydgoto[$yym];
    }
#if YYDEBUG
    print "yydebug: after reduction, shifting from state ",
        "$yyss[$yyssp] to state $yystate\n" if $yydebug;
#endif
    $yyss[++$yyssp] = $yystate;
    $yyvs[++$yyvsp] = $yyval;
  } # yyloop
} # yyparse
#line 83 "GetDate.y"

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

#line 512 "GetDate.tab.pl"
