$yysccsid = "@(#)yaccpar 1.8 (Berkeley) 01/20/91 (Perl 2.0 12/31/92)";
#define YYBYACC 1
#line 2 "GetDate.y"
;###############################################################################
;## Date::GetDate.y
;##
;## Version 1.00  05-Jan-95  Graham Barr  bodg@tiuk.ti.com
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
;###############################################################################

print $yysccsid if defined $print_yysccsid_string;

package Date::GetDate;

use Time::Local;
require 5.000;
require Exporter;
@ISA = (Exporter);

@EXPORT = qw( &strtotime );

sub yyerror { $error = 1; }

#line 35 "GetDate.tab.pl"
$NUM=257;
$MONTH=258;
$AM=259;
$PM=260;
$YYERRCODE=256;
@yylhs = (                                               -1,
    0,    0,    0,    0,    0,    0,    0,    0,    1,    1,
    1,    3,    3,    2,    2,    2,    4,    4,
);
@yylen = (                                                2,
    3,    3,    3,    2,    2,    2,    1,    1,    2,    2,
    3,    2,    1,    2,    2,    1,    5,    3,
);
@yydefred = (                                             0,
    0,    0,    0,    0,    0,    0,    9,    0,    0,   10,
    0,    0,    0,    0,    0,    0,   14,   15,   11,    0,
   12,   13,    1,    0,    2,    3,    0,   17,
);
@yydgoto = (                                              3,
    4,    5,   14,    6,
);
@yysindex = (                                          -243,
  -47, -249,    0,  -43, -241, -240,    0, -247, -239,    0,
  -37, -235,  -41, -234,  -45,  -41,    0,    0,    0,  -34,
    0,    0,    0,  -37,    0,    0, -232,    0,
);
@yyrindex = (                                             0,
    0,    0,    0,   26,   27,    5,    0,    0,    0,    0,
    7,    0,   28,   29,    0,   30,    0,    0,    0,    1,
    0,    0,    0,    0,    0,    0,    0,    0,
);
@yygindex = (                                             0,
   31,   -1,   -4,    0,
);
$YYTABLESIZE=264;
@yytable = (                                              8,
   18,    8,   13,   12,   16,   12,   13,   10,   23,   19,
    9,   26,   25,    1,    2,   15,    2,   20,   17,   18,
    9,   21,   24,   27,   28,    7,    8,    5,    6,    4,
    0,    0,    0,    0,    0,   16,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   18,    0,    0,
    0,   16,    0,    0,    0,    0,    0,    0,    0,    0,
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
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    7,    0,    7,   11,    0,   22,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   18,   18,   18,
   18,   16,   16,   13,
);
@yycheck = (                                             47,
    0,   47,    4,   47,    0,   47,    0,  257,   13,  257,
   58,   16,   14,  257,  258,  257,  258,  257,  259,  260,
   58,  257,  257,   58,  257,    0,    0,    0,    0,    0,
   -1,   -1,   -1,   -1,   -1,    5,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   47,   -1,   -1,
   -1,   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
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
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
  258,   -1,  258,  257,   -1,  257,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,  258,  259,
  260,  257,  258,  257,
);
$YYFINAL=3;
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
$YYMAXTOKEN=260;
#if YYDEBUG
@yyname = (
"end-of-file",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','',"'/'",'','','','','','','','','','',"':'",'','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','',"NUM","MONTH","AM","PM",
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
"day : MONTH NUM",
"day : NUM '/' NUM",
"year : '/' NUM",
"year : NUM",
"time : clock AM",
"time : clock PM",
"time : clock",
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
#line 48 "GetDate.y"
{ $month = $yyvs[$yyvsp-0] % 12; $day = $yyvs[$yyvsp-1]; 
last switch;
} }
if ($yyn == 10) {
#line 49 "GetDate.y"
{ $month = $yyvs[$yyvsp-1] % 12; $day = $yyvs[$yyvsp-0]; 
last switch;
} }
if ($yyn == 11) {
#line 50 "GetDate.y"
{ $month = $yyvs[$yyvsp-2] % 12; $day = $yyvs[$yyvsp-0]; 
last switch;
} }
if ($yyn == 12) {
#line 53 "GetDate.y"
{ $year = $yyvs[$yyvsp-0] % 100; 
last switch;
} }
if ($yyn == 13) {
#line 54 "GetDate.y"
{ $year = $yyvs[$yyvsp-0] % 100; 
last switch;
} }
if ($yyn == 14) {
#line 57 "GetDate.y"
{ $hour %= 12; 
last switch;
} }
if ($yyn == 15) {
#line 58 "GetDate.y"
{ $hour  = ($hour % 12) + 12; 
last switch;
} }
if ($yyn == 17) {
#line 62 "GetDate.y"
{ $hour = $yyvs[$yyvsp-4] % 24; $min = $yyvs[$yyvsp-2] % 60; $sec = $yyvs[$yyvsp-0] % 60; 
last switch;
} }
if ($yyn == 18) {
#line 63 "GetDate.y"
{ $hour = $yyvs[$yyvsp-2] % 24; $min = $yyvs[$yyvsp-0] % 60; 
last switch;
} }
#line 335 "GetDate.tab.pl"
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
#line 67 "GetDate.y"

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
   elsif($string =~ s/\A\s*([\-\+](\d)?\d)(\d\d)\s*//)
    {
     $delta -= ($1 * 60) + $3 unless $delta;

     next YYLEX;
    }
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

       $delta -= $zone{$key} unless $delta;
       next YYLEX;
      }

     return $PM if $mon =~ /^p\.?m\.?$/;
     return $AM if $mon =~ /^a\.?m\.?$/;
    }
   elsif($string =~ s/\A\s*([:\/])\s*//)
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

 $time += ($delta * 60);

 return $time;
}

__END__

#line 465 "GetDate.tab.pl"
