/* extern char *malloc(), *realloc(); */

# line 2 "getdate.y"
/*
**  Originally written by Steven M. Bellovin <smb@research.att.com> while
**  at the University of North Carolina at Chapel Hill.  Later tweaked by
**  a couple of people on Usenet.  Completely overhauled by Rich $alz
**  <rsalz@bbn.com> and Jim Berets <jberets@bbn.com> in August, 1990;
**  send any email to Rich.
**
**  This grammar has nine shift/reduce conflicts.
**
**  This code is in the public domain and has no copyright.
*/
/* SUPPRESS 287 on yaccpar_sccsid *//* Unusd static variable */
/* SUPPRESS 288 on THIS_yyerrlab *//* Label unused */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

/* Since the code of getdate.y is not included in the Emacs executable
   itself, there is no need to #define static in this file.  Even if
   the code were included in the Emacs executable, it probably
   wouldn't do any harm to #undef it here; this will only cause
   problems if we try to write to a static variable, which I don't
   think this code needs to do.  */
#ifdef emacs
#undef static
#endif

#ifdef __GNUC__
#define alloca __builtin_alloca
#else
#ifdef HAVE_ALLOCA_H
#include <alloca.h>
#else
#ifdef _AIX /* for Bison */
 #pragma alloca
#else
char *alloca ();
#endif
#endif
#endif

#include <stdio.h>
#include <ctype.h>

/* The code at the top of getdate which figures out the offset of the
   current time zone checks various CPP symbols to see if special
   tricks are need, but defaults to using the gettimeofday system call.
   Include <sys/time.h> if that will be used.  */

#if	defined(vms)

#include <types.h>
#include <time.h>

#else

#include <sys/types.h>

#if sgi
#undef timezone
#endif

/* If the configuration process hasn't #define HAVE_GETTIMEOFDAY, try
   to guess it.  */
#ifndef HAVE_GETTIMEOFDAY

/* We know these machines have it.  */
#ifdef BSD4_2
#define HAVE_GETTIMEOFDAY
#endif

#ifdef BSD4_1C
#define HAVE_GETTIMEOFDAY
#endif

#if (defined (hp9000) && !defined (hpux))
#define HAVE_GETTIMEOFDAY
#endif

#ifdef _AIX
#define HAVE_GETTIMEOFDAY
#endif

/* We know these machines don't.  We could just omit these, but some of
   these CPP symbols are more specific than the ones above, so we want
   to override them if any of the above are #defined.  */
#ifdef USG
#undef HAVE_GETTIMEOFDAY
#endif

#ifdef sgi
#undef HAVE_GETTIMEOFDAY
#endif

#ifdef __386BSD__
#undef HAVE_GETTIMEOFDAY
#endif

#endif

#ifdef TIME_WITH_SYS_TIME
#include <sys/time.h>
#include <time.h>
#else
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#else
#include <time.h>
#endif
#endif

#if defined(HAVE_SYS_TIMEB_H) || (!defined(USG) && defined(HAVE_FTIME))
#include <sys/timeb.h>
#else
/*
**  If you need to do a tzset() call to set the
**  timezone, and don't have ftime().
*/
struct timeb {
    time_t		time;		/* Seconds since the epoch	*/
    unsigned short	millitm;	/* Field not used		*/
    short		timezone;
    short		dstflag;	/* Field not used		*/
};
#endif /* defined(HAVE_SYS_TIMEB_H) || (!defined(USG) && defined(HAVE_FTIME))*/

#endif	/* defined(vms) */

#if defined (STDC_HEADERS) || defined (USG)
#include <string.h>
#endif

/* Some old versions of bison generate parsers that use bcopy.
   That loses on systems that don't provide the function, so we have
   to redefine it here.  */
#if !defined (HAVE_BCOPY) && defined (HAVE_MEMCPY) && !defined (bcopy)
#define bcopy(from, to, len) memcpy ((to), (from), (len))
#endif

extern struct tm	*localtime();

#define THIS_yyparse getdate_THIS_yyparse
#define THIS_yylex getdate_THIS_yylex
#define THIS_yyerror getdate_THIS_yyerror

static int THIS_yylex ();
static int THIS_yyerror ();

#if	!defined(lint) && !defined(SABER)
static char RCS[] =
	"$Header: /usr/home/k/sources/Date-GetDate-2.00-ak/getdate.c,v 1.1 1998/07/12 14:46:17 k Exp $";
#endif	/* !defined(lint) && !defined(SABER) */


#define EPOCH		1970
#define HOUR(x)		((time_t)(x) * 60)
#define SECSPERDAY	(24L * 60L * 60L)


/*
**  An entry in the lexical lookup table.
*/
typedef struct _TABLE {
    char	*name;
    int		type;
    time_t	value;
} TABLE;


/*
**  Daylight-savings mode:  on, off, or not yet known.
*/
typedef enum _DSTMODE {
    DSTon, DSToff, DSTmaybe
} DSTMODE;

/*
**  Meridian:  am, pm, or 24-hour style.
*/
typedef enum _MERIDIAN {
    MERam, MERpm, MER24
} MERIDIAN;


/*
**  Global variables.  We could get rid of most of these by using a good
**  union as the yacc stack.  (This routine was originally written before
**  yacc had the %union construct.)  Maybe someday; right now we only use
**  the %union very rarely.
*/
static char	*THIS_yyInput;
static DSTMODE	THIS_yyDSTmode;
static time_t	THIS_yyDayOrdinal;
static time_t	THIS_yyDayNumber;
static int	THIS_yyHaveDate;
static int	THIS_yyHaveDay;
static int	THIS_yyHaveRel;
static int	THIS_yyHaveTime;
static int	THIS_yyHaveZone;
static time_t	THIS_yyTimezone;
static time_t	THIS_yyDay;
static time_t	THIS_yyHour;
static time_t	THIS_yyMinutes;
static time_t	THIS_yyMonth;
static time_t	THIS_yySeconds;
static time_t	THIS_yyYear;
static MERIDIAN	THIS_yyMeridian;
static time_t	THIS_yyRelMonth;
static time_t	THIS_yyRelSeconds;


# line 215 "getdate.y"
typedef union  {
    time_t		Number;
    enum _MERIDIAN	Meridian;
} this_YYSTYPE;
# define tAGO 257
# define tDAY 258
# define tDAYZONE 259
# define tID 260
# define tMERIDIAN 261
# define tMINUTE_UNIT 262
# define tMONTH 263
# define tMONTH_UNIT 264
# define tSEC_UNIT 265
# define tSNUMBER 266
# define tUNUMBER 267
# define tZONE 268
# define tDST 269
#define THIS_yyclearin THIS_yychar = -1
#define THIS_yyerrok THIS_yyerrflag = 0
extern int THIS_yychar;
extern int THIS_yyerrflag;
#ifndef this_YYMAXDEPTH
#define this_YYMAXDEPTH 150
#endif
this_YYSTYPE THIS_yylval, THIS_yyval;
# define this_YYERRCODE 256

# line 422 "getdate.y"


/* Month and day table. */
static TABLE const MonthDayTable[] = {
    { "january",	tMONTH,  1 },
    { "february",	tMONTH,  2 },
    { "march",		tMONTH,  3 },
    { "april",		tMONTH,  4 },
    { "may",		tMONTH,  5 },
    { "june",		tMONTH,  6 },
    { "july",		tMONTH,  7 },
    { "august",		tMONTH,  8 },
    { "september",	tMONTH,  9 },
    { "sept",		tMONTH,  9 },
    { "october",	tMONTH, 10 },
    { "november",	tMONTH, 11 },
    { "december",	tMONTH, 12 },
    { "sunday",		tDAY, 0 },
    { "monday",		tDAY, 1 },
    { "tuesday",	tDAY, 2 },
    { "tues",		tDAY, 2 },
    { "wednesday",	tDAY, 3 },
    { "wednes",		tDAY, 3 },
    { "thursday",	tDAY, 4 },
    { "thur",		tDAY, 4 },
    { "thurs",		tDAY, 4 },
    { "friday",		tDAY, 5 },
    { "saturday",	tDAY, 6 },
    { NULL }
};

/* Time units table. */
static TABLE const UnitsTable[] = {
    { "year",		tMONTH_UNIT,	12 },
    { "month",		tMONTH_UNIT,	1 },
    { "fortnight",	tMINUTE_UNIT,	14 * 24 * 60 },
    { "week",		tMINUTE_UNIT,	7 * 24 * 60 },
    { "day",		tMINUTE_UNIT,	1 * 24 * 60 },
    { "hour",		tMINUTE_UNIT,	60 },
    { "minute",		tMINUTE_UNIT,	1 },
    { "min",		tMINUTE_UNIT,	1 },
    { "second",		tSEC_UNIT,	1 },
    { "sec",		tSEC_UNIT,	1 },
    { NULL }
};

/* Assorted relative-time words. */
static TABLE const OtherTable[] = {
    { "tomorrow",	tMINUTE_UNIT,	1 * 24 * 60 },
    { "yesterday",	tMINUTE_UNIT,	-1 * 24 * 60 },
    { "today",		tMINUTE_UNIT,	0 },
    { "now",		tMINUTE_UNIT,	0 },
    { "last",		tUNUMBER,	-1 },
    { "this",		tMINUTE_UNIT,	0 },
    { "next",		tUNUMBER,	2 },
    { "first",		tUNUMBER,	1 },
/*  { "second",		tUNUMBER,	2 }, */
    { "third",		tUNUMBER,	3 },
    { "fourth",		tUNUMBER,	4 },
    { "fifth",		tUNUMBER,	5 },
    { "sixth",		tUNUMBER,	6 },
    { "seventh",	tUNUMBER,	7 },
    { "eighth",		tUNUMBER,	8 },
    { "ninth",		tUNUMBER,	9 },
    { "tenth",		tUNUMBER,	10 },
    { "eleventh",	tUNUMBER,	11 },
    { "twelfth",	tUNUMBER,	12 },
    { "ago",		tAGO,	1 },
    { NULL }
};

/* The timezone table. */
/* Some of these are commented out because a time_t can't store a float. */
static TABLE const TimezoneTable[] = {
    { "gmt",	tZONE,     HOUR( 0) },	/* Greenwich Mean */
    { "ut",	tZONE,     HOUR( 0) },	/* Universal (Coordinated) */
    { "utc",	tZONE,     HOUR( 0) },
    { "wet",	tZONE,     HOUR( 0) },	/* Western European */
    { "bst",	tDAYZONE,  HOUR( 0) },	/* British Summer */
    { "wat",	tZONE,     HOUR( 1) },	/* West Africa */
    { "at",	tZONE,     HOUR( 2) },	/* Azores */
#if	0
    /* For completeness.  BST is also British Summer, and GST is
     * also Guam Standard. */
    { "bst",	tZONE,     HOUR( 3) },	/* Brazil Standard */
    { "gst",	tZONE,     HOUR( 3) },	/* Greenland Standard */
#endif
#if 0
    { "nft",	tZONE,     HOUR(3.5) },	/* Newfoundland */
    { "nst",	tZONE,     HOUR(3.5) },	/* Newfoundland Standard */
    { "ndt",	tDAYZONE,  HOUR(3.5) },	/* Newfoundland Daylight */
#endif
    { "ast",	tZONE,     HOUR( 4) },	/* Atlantic Standard */
    { "adt",	tDAYZONE,  HOUR( 4) },	/* Atlantic Daylight */
    { "est",	tZONE,     HOUR( 5) },	/* Eastern Standard */
    { "edt",	tDAYZONE,  HOUR( 5) },	/* Eastern Daylight */
    { "cst",	tZONE,     HOUR( 6) },	/* Central Standard */
    { "cdt",	tDAYZONE,  HOUR( 6) },	/* Central Daylight */
    { "mst",	tZONE,     HOUR( 7) },	/* Mountain Standard */
    { "mdt",	tDAYZONE,  HOUR( 7) },	/* Mountain Daylight */
    { "pst",	tZONE,     HOUR( 8) },	/* Pacific Standard */
    { "pdt",	tDAYZONE,  HOUR( 8) },	/* Pacific Daylight */
    { "yst",	tZONE,     HOUR( 9) },	/* Yukon Standard */
    { "ydt",	tDAYZONE,  HOUR( 9) },	/* Yukon Daylight */
    { "hst",	tZONE,     HOUR(10) },	/* Hawaii Standard */
    { "hdt",	tDAYZONE,  HOUR(10) },	/* Hawaii Daylight */
    { "cat",	tZONE,     HOUR(10) },	/* Central Alaska */
    { "ahst",	tZONE,     HOUR(10) },	/* Alaska-Hawaii Standard */
    { "nt",	tZONE,     HOUR(11) },	/* Nome */
    { "idlw",	tZONE,     HOUR(12) },	/* International Date Line West */
    { "cet",	tZONE,     -HOUR(1) },	/* Central European */
    { "met",	tZONE,     -HOUR(1) },	/* Middle European */
    { "mewt",	tZONE,     -HOUR(1) },	/* Middle European Winter */
    { "mest",	tDAYZONE,  -HOUR(1) },	/* Middle European Summer */
    { "swt",	tZONE,     -HOUR(1) },	/* Swedish Winter */
    { "sst",	tDAYZONE,  -HOUR(1) },	/* Swedish Summer */
    { "fwt",	tZONE,     -HOUR(1) },	/* French Winter */
    { "fst",	tDAYZONE,  -HOUR(1) },	/* French Summer */
    { "eet",	tZONE,     -HOUR(2) },	/* Eastern Europe, USSR Zone 1 */
    { "bt",	tZONE,     -HOUR(3) },	/* Baghdad, USSR Zone 2 */
#if 0
    { "it",	tZONE,     -HOUR(3.5) },/* Iran */
#endif
    { "zp4",	tZONE,     -HOUR(4) },	/* USSR Zone 3 */
    { "zp5",	tZONE,     -HOUR(5) },	/* USSR Zone 4 */
#if 0
    { "ist",	tZONE,     -HOUR(5.5) },/* Indian Standard */
#endif
    { "zp6",	tZONE,     -HOUR(6) },	/* USSR Zone 5 */
#if	0
    /* For completeness.  NST is also Newfoundland Stanard, and SST is
     * also Swedish Summer. */
    { "nst",	tZONE,     -HOUR(6.5) },/* North Sumatra */
    { "sst",	tZONE,     -HOUR(7) },	/* South Sumatra, USSR Zone 6 */
#endif	/* 0 */
    { "wast",	tZONE,     -HOUR(7) },	/* West Australian Standard */
    { "wadt",	tDAYZONE,  -HOUR(7) },	/* West Australian Daylight */
#if 0
    { "jt",	tZONE,     -HOUR(7.5) },/* Java (3pm in Cronusland!) */
#endif
    { "cct",	tZONE,     -HOUR(8) },	/* China Coast, USSR Zone 7 */
    { "jst",	tZONE,     -HOUR(9) },	/* Japan Standard, USSR Zone 8 */
#if 0
    { "cast",	tZONE,     -HOUR(9.5) },/* Central Australian Standard */
    { "cadt",	tDAYZONE,  -HOUR(9.5) },/* Central Australian Daylight */
#endif
    { "east",	tZONE,     -HOUR(10) },	/* Eastern Australian Standard */
    { "eadt",	tDAYZONE,  -HOUR(10) },	/* Eastern Australian Daylight */
    { "gst",	tZONE,     -HOUR(10) },	/* Guam Standard, USSR Zone 9 */
    { "nzt",	tZONE,     -HOUR(12) },	/* New Zealand */
    { "nzst",	tZONE,     -HOUR(12) },	/* New Zealand Standard */
    { "nzdt",	tDAYZONE,  -HOUR(12) },	/* New Zealand Daylight */
    { "idle",	tZONE,     -HOUR(12) },	/* International Date Line East */
    {  NULL  }
};

/* Military timezone table. */
static TABLE const MilitaryTable[] = {
    { "a",	tZONE,	HOUR(  1) },
    { "b",	tZONE,	HOUR(  2) },
    { "c",	tZONE,	HOUR(  3) },
    { "d",	tZONE,	HOUR(  4) },
    { "e",	tZONE,	HOUR(  5) },
    { "f",	tZONE,	HOUR(  6) },
    { "g",	tZONE,	HOUR(  7) },
    { "h",	tZONE,	HOUR(  8) },
    { "i",	tZONE,	HOUR(  9) },
    { "k",	tZONE,	HOUR( 10) },
    { "l",	tZONE,	HOUR( 11) },
    { "m",	tZONE,	HOUR( 12) },
    { "n",	tZONE,	HOUR(- 1) },
    { "o",	tZONE,	HOUR(- 2) },
    { "p",	tZONE,	HOUR(- 3) },
    { "q",	tZONE,	HOUR(- 4) },
    { "r",	tZONE,	HOUR(- 5) },
    { "s",	tZONE,	HOUR(- 6) },
    { "t",	tZONE,	HOUR(- 7) },
    { "u",	tZONE,	HOUR(- 8) },
    { "v",	tZONE,	HOUR(- 9) },
    { "w",	tZONE,	HOUR(-10) },
    { "x",	tZONE,	HOUR(-11) },
    { "y",	tZONE,	HOUR(-12) },
    { "z",	tZONE,	HOUR(  0) },
    { NULL }
};




/* ARGSUSED */
static int
THIS_yyerror(s)
    char	*s;
{
  return 0;
}


static time_t
ToSeconds(Hours, Minutes, Seconds, Meridian)
    time_t	Hours;
    time_t	Minutes;
    time_t	Seconds;
    MERIDIAN	Meridian;
{
    if (Minutes < 0 || Minutes > 59 || Seconds < 0 || Seconds > 59)
	return -1;
    switch (Meridian) {
    case MER24:
	if (Hours < 0 || Hours > 23)
	    return -1;
	return (Hours * 60L + Minutes) * 60L + Seconds;
    case MERam:
	if (Hours < 1 || Hours > 12)
	    return -1;
	return (Hours * 60L + Minutes) * 60L + Seconds;
    case MERpm:
	if (Hours < 1 || Hours > 12)
	    return -1;
	return ((Hours + 12) * 60L + Minutes) * 60L + Seconds;
    }
    /* NOTREACHED */
}


static time_t
Convert(Month, Day, Year, Hours, Minutes, Seconds, Meridian, DSTmode)
    time_t	Month;
    time_t	Day;
    time_t	Year;
    time_t	Hours;
    time_t	Minutes;
    time_t	Seconds;
    MERIDIAN	Meridian;
    DSTMODE	DSTmode;
{
    static int DaysInMonth[12] = {
	31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    };
    time_t	tod;
    time_t	Julian;
    int		i;

    if (Year < 0)
	Year = -Year;
    if (Year < 100)
	Year += 1900;
    DaysInMonth[1] = Year % 4 == 0 && (Year % 100 != 0 || Year % 400 == 0)
		    ? 29 : 28;
    if (Year < EPOCH || Year > 1999
     || Month < 1 || Month > 12
     /* Lint fluff:  "conversion from long may lose accuracy" */
     || Day < 1 || Day > DaysInMonth[(int)--Month])
	return -1;

    for (Julian = Day - 1, i = 0; i < Month; i++)
	Julian += DaysInMonth[i];
    for (i = EPOCH; i < Year; i++)
	Julian += 365 + (i % 4 == 0);
    Julian *= SECSPERDAY;
    Julian += THIS_yyTimezone * 60L;
    if ((tod = ToSeconds(Hours, Minutes, Seconds, Meridian)) < 0)
	return -1;
    Julian += tod;
    if (DSTmode == DSTon
     || (DSTmode == DSTmaybe && localtime(&Julian)->tm_isdst))
	Julian -= 60 * 60;
    return Julian;
}


static time_t
DSTcorrect(Start, Future)
    time_t	Start;
    time_t	Future;
{
    time_t	StartDay;
    time_t	FutureDay;

    StartDay = (localtime(&Start)->tm_hour + 1) % 24;
    FutureDay = (localtime(&Future)->tm_hour + 1) % 24;
    return (Future - Start) + (StartDay - FutureDay) * 60L * 60L;
}


static time_t
RelativeDate(Start, DayOrdinal, DayNumber)
    time_t	Start;
    time_t	DayOrdinal;
    time_t	DayNumber;
{
    struct tm	*tm;
    time_t	now;

    now = Start;
    tm = localtime(&now);
    now += SECSPERDAY * ((DayNumber - tm->tm_wday + 7) % 7);
    now += 7 * SECSPERDAY * (DayOrdinal <= 0 ? DayOrdinal : DayOrdinal - 1);
    return DSTcorrect(Start, now);
}


static time_t
RelativeMonth(Start, RelMonth)
    time_t	Start;
    time_t	RelMonth;
{
    struct tm	*tm;
    time_t	Month;
    time_t	Year;

    if (RelMonth == 0)
	return 0;
    tm = localtime(&Start);
    Month = 12 * tm->tm_year + tm->tm_mon + RelMonth;
    Year = Month / 12;
    Month = Month % 12 + 1;
    return DSTcorrect(Start,
	    Convert(Month, (time_t)tm->tm_mday, Year,
		(time_t)tm->tm_hour, (time_t)tm->tm_min, (time_t)tm->tm_sec,
		MER24, DSTmaybe));
}


static int
LookupWord(buff)
    char		*buff;
{
    register char	*p;
    register char	*q;
    register const TABLE	*tp;
    int			i;
    int			abbrev;

    /* Make it lowercase. */
    for (p = buff; *p; p++)
	if (isupper(*p))
	    *p = tolower(*p);

    if (strcmp(buff, "am") == 0 || strcmp(buff, "a.m.") == 0) {
	THIS_yylval.Meridian = MERam;
	return tMERIDIAN;
    }
    if (strcmp(buff, "pm") == 0 || strcmp(buff, "p.m.") == 0) {
	THIS_yylval.Meridian = MERpm;
	return tMERIDIAN;
    }

    /* See if we have an abbreviation for a month. */
    if (strlen(buff) == 3)
	abbrev = 1;
    else if (strlen(buff) == 4 && buff[3] == '.') {
	abbrev = 1;
	buff[3] = '\0';
    }
    else
	abbrev = 0;

    for (tp = MonthDayTable; tp->name; tp++) {
	if (abbrev) {
	    if (strncmp(buff, tp->name, 3) == 0) {
		THIS_yylval.Number = tp->value;
		return tp->type;
	    }
	}
	else if (strcmp(buff, tp->name) == 0) {
	    THIS_yylval.Number = tp->value;
	    return tp->type;
	}
    }

    for (tp = TimezoneTable; tp->name; tp++)
	if (strcmp(buff, tp->name) == 0) {
	    THIS_yylval.Number = tp->value;
	    return tp->type;
	}

    if (strcmp(buff, "dst") == 0) 
	return tDST;

    for (tp = UnitsTable; tp->name; tp++)
	if (strcmp(buff, tp->name) == 0) {
	    THIS_yylval.Number = tp->value;
	    return tp->type;
	}

    /* Strip off any plural and try the units table again. */
    i = strlen(buff) - 1;
    if (buff[i] == 's') {
	buff[i] = '\0';
	for (tp = UnitsTable; tp->name; tp++)
	    if (strcmp(buff, tp->name) == 0) {
		THIS_yylval.Number = tp->value;
		return tp->type;
	    }
	buff[i] = 's';		/* Put back for "this" in OtherTable. */
    }

    for (tp = OtherTable; tp->name; tp++)
	if (strcmp(buff, tp->name) == 0) {
	    THIS_yylval.Number = tp->value;
	    return tp->type;
	}

    /* Military timezones. */
    if (buff[1] == '\0' && isalpha(*buff)) {
	for (tp = MilitaryTable; tp->name; tp++)
	    if (strcmp(buff, tp->name) == 0) {
		THIS_yylval.Number = tp->value;
		return tp->type;
	    }
    }

    /* Drop out any periods and try the timezone table again. */
    for (i = 0, p = q = buff; *q; q++)
	if (*q != '.')
	    *p++ = *q;
	else
	    i++;
    *p = '\0';
    if (i)
	for (tp = TimezoneTable; tp->name; tp++)
	    if (strcmp(buff, tp->name) == 0) {
		THIS_yylval.Number = tp->value;
		return tp->type;
	    }

    return tID;
}


static int
THIS_yylex()
{
    register char	c;
    register char	*p;
    char		buff[20];
    int			Count;
    int			sign;

    for ( ; ; ) {
	while (isspace(*THIS_yyInput))
	    THIS_yyInput++;

	if (isdigit(c = *THIS_yyInput) || c == '-' || c == '+') {
	    if (c == '-' || c == '+') {
		sign = c == '-' ? -1 : 1;
		if (!isdigit(*++THIS_yyInput))
		    /* skip the '-' sign */
		    continue;
	    }
	    else
		sign = 0;
	    for (THIS_yylval.Number = 0; isdigit(c = *THIS_yyInput++); )
		THIS_yylval.Number = 10 * THIS_yylval.Number + c - '0';
	    THIS_yyInput--;
	    if (sign < 0)
		THIS_yylval.Number = -THIS_yylval.Number;
	    return sign ? tSNUMBER : tUNUMBER;
	}
	if (isalpha(c)) {
	    for (p = buff; isalpha(c = *THIS_yyInput++) || c == '.'; )
		if (p < &buff[sizeof buff - 1])
		    *p++ = c;
	    *p = '\0';
	    THIS_yyInput--;
	    return LookupWord(buff);
	}
	if (c != '(')
	    return *THIS_yyInput++;
	Count = 0;
	do {
	    c = *THIS_yyInput++;
	    if (c == '\0')
		return c;
	    if (c == '(')
		Count++;
	    else if (c == ')')
		Count--;
	} while (Count > 0);
    }
}


time_t
salz_getdate(p, now)
    char		*p;
    struct timeb	*now;
{
    struct tm		*tm;
    struct timeb	ftz;
    time_t		Start;
    time_t		tod;

    THIS_yyInput = p;
    if (now == NULL) {
        now = &ftz;
#if	!defined(HAVE_FTIME)
	(void)time(&ftz.time);
	/* Set the timezone global. */
	tzset();
	{
#ifdef HAVE_GETTIMEOFDAY
	    struct timeval tv;
	    struct timezone tz;

	    gettimeofday (&tv, &tz);
	    ftz.timezone = (int) tz.tz_minuteswest;
#else /* not HAVE_GETTIMEOFDAY */ 
#if sgi
	    ftz.timezone = (int) _timezone / 60;
#else /* not HAVE_GETTIMEOFDAY, nor sgi */
#ifdef __386BSD__
	    ftz.timezone = 0;
#else /* not HAVE_GETTIMEOFDAY, nor sgi, nor 386BSD -- probably USG */
	    extern time_t timezone;

	    ftz.timezone = (int) timezone / 60;
#endif /* not HAVE_GETTIMEOFDAY, nor sgi, nor 386BSD -- probably USG */
#endif /* not HAVE_GETTIMEOFDAY, nor sgi */
#endif /* not HAVE_GETTIMEOFDAY */
	}
#else /* HAVE_FTIME */
	(void)ftime(&ftz);
#endif /* HAVE_FTIME */
    }

    tm = localtime(&now->time);
    THIS_yyYear = tm->tm_year;
    THIS_yyMonth = tm->tm_mon + 1;
    THIS_yyDay = tm->tm_mday;
    THIS_yyTimezone = now->timezone;
    THIS_yyDSTmode = DSTmaybe;
    THIS_yyHour = 0;
    THIS_yyMinutes = 0;
    THIS_yySeconds = 0;
    THIS_yyMeridian = MER24;
    THIS_yyRelSeconds = 0;
    THIS_yyRelMonth = 0;
    THIS_yyHaveDate = 0;
    THIS_yyHaveDay = 0;
    THIS_yyHaveRel = 0;
    THIS_yyHaveTime = 0;
    THIS_yyHaveZone = 0;

    if (THIS_yyparse()
     || THIS_yyHaveTime > 1 || THIS_yyHaveZone > 1 || THIS_yyHaveDate > 1 || THIS_yyHaveDay > 1)
	return -1;

    if (THIS_yyHaveDate || THIS_yyHaveTime || THIS_yyHaveDay) {
	Start = Convert(THIS_yyMonth, THIS_yyDay, THIS_yyYear, THIS_yyHour, THIS_yyMinutes, THIS_yySeconds,
		    THIS_yyMeridian, THIS_yyDSTmode);
	if (Start < 0)
	    return -1;
    }
    else {
	Start = now->time;
	if (!THIS_yyHaveRel)
	    Start -= ((tm->tm_hour * 60L + tm->tm_min) * 60L) + tm->tm_sec;
    }

    Start += THIS_yyRelSeconds;
    Start += RelativeMonth(Start, THIS_yyRelMonth);

    if (THIS_yyHaveDay && !THIS_yyHaveDate) {
	tod = RelativeDate(Start, THIS_yyDayOrdinal, THIS_yyDayNumber);
	Start += tod;
    }

    /* Have to do *something* with a legitimate -1 so it's distinguishable
     * from the error return value.  (Alternately could set errno on error.) */
    return Start == -1 ? 0 : Start;
}


#if	defined(TEST)

/* ARGSUSED */
main(ac, av)
    int		ac;
    char	*av[];
{
    char	buff[128];
    time_t	d;

    (void)printf("Enter date, or blank line to exit.\n\t> ");
    (void)fflush(stdout);
    while (gets(buff) && buff[0]) {
	d = salz_getdate(buff, (struct timeb *)NULL);
	if (d == -1)
	    (void)printf("Bad format - couldn't convert.\n");
	else
	    (void)printf("%s", ctime(&d));
	(void)printf("\t> ");
	(void)fflush(stdout);
    }
    exit(0);
    /* NOTREACHED */
}
#endif	/* defined(TEST) */
int THIS_yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
	};
# define this_YYNPROD 41
# define this_YYLAST 228
int THIS_yyact[]={

    13,    11,    22,    28,    16,    12,    18,    17,    15,     9,
    10,    43,    47,    20,    46,    45,    49,    44,    38,    42,
    36,    35,    32,    29,    34,    33,    31,    37,    40,    39,
    30,    14,     8,     7,     6,     5,     4,     3,     2,     1,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,    48,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,    21,     0,     0,    19,    25,    24,    27,
    26,    23,    43,     0,     0,     0,     0,    41 };
int THIS_yypact[]={

 -1000,  -258, -1000, -1000, -1000, -1000, -1000, -1000, -1000,   -45,
  -266, -1000,  -244,   -14,  -231,  -240, -1000, -1000, -1000, -1000,
  -246, -1000,  -247,  -239,  -249, -1000, -1000, -1000, -1000,   -15,
 -1000, -1000, -1000, -1000, -1000,   -39,   -30, -1000, -1000,  -252,
 -1000, -1000,  -253, -1000,  -255, -1000,  -250, -1000, -1000, -1000 };
int THIS_yypgo[]={

     0,    28,    39,    38,    37,    36,    35,    34,    33,    32,
    31 };
int THIS_yyr1[]={

     0,     2,     2,     3,     3,     3,     3,     3,     3,     4,
     4,     4,     4,     4,     5,     5,     5,     7,     7,     7,
     6,     6,     6,     6,     6,     6,     6,     8,     8,    10,
    10,    10,    10,    10,    10,    10,    10,    10,     9,     1,
     1 };
int THIS_yyr2[]={

     0,     0,     4,     3,     3,     3,     3,     3,     2,     5,
     9,     9,    13,    13,     3,     3,     5,     3,     5,     5,
     7,    11,     7,     5,     9,     5,     7,     5,     2,     5,
     5,     3,     5,     5,     3,     5,     5,     3,     3,     1,
     3 };
int THIS_yychk[]={

 -1000,    -2,    -3,    -4,    -5,    -6,    -7,    -8,    -9,   267,
   268,   259,   263,   258,   -10,   266,   262,   265,   264,   261,
    58,   258,    47,   266,   263,   262,   265,   264,   269,   267,
    44,   257,   262,   265,   264,   267,   267,   266,   267,    44,
    -1,   266,    58,   261,    47,   267,   267,   267,    -1,   266 };
int THIS_yydef[]={

     1,    -2,     2,     3,     4,     5,     6,     7,     8,    38,
    14,    15,     0,    17,    28,     0,    31,    34,    37,     9,
     0,    19,     0,     0,    25,    29,    33,    36,    16,    23,
    18,    27,    30,    32,    35,    39,    20,    22,    26,     0,
    10,    11,     0,    40,     0,    24,    39,    21,    12,    13 };
typedef struct { char *t_name; int t_val; } THIS_yytoktype;
#ifndef this_YYDEBUG
#	define this_YYDEBUG	0	/* don't allow debugging */
#endif

#if this_YYDEBUG

THIS_yytoktype THIS_yytoks[] =
{
	"tAGO",	257,
	"tDAY",	258,
	"tDAYZONE",	259,
	"tID",	260,
	"tMERIDIAN",	261,
	"tMINUTE_UNIT",	262,
	"tMONTH",	263,
	"tMONTH_UNIT",	264,
	"tSEC_UNIT",	265,
	"tSNUMBER",	266,
	"tUNUMBER",	267,
	"tZONE",	268,
	"tDST",	269,
	"-unknown-",	-1	/* ends search */
};

char * THIS_yyreds[] =
{
	"-no such reduction-",
	"spec : /* empty */",
	"spec : spec item",
	"item : time",
	"item : zone",
	"item : date",
	"item : day",
	"item : rel",
	"item : number",
	"time : tUNUMBER tMERIDIAN",
	"time : tUNUMBER ':' tUNUMBER o_merid",
	"time : tUNUMBER ':' tUNUMBER tSNUMBER",
	"time : tUNUMBER ':' tUNUMBER ':' tUNUMBER o_merid",
	"time : tUNUMBER ':' tUNUMBER ':' tUNUMBER tSNUMBER",
	"zone : tZONE",
	"zone : tDAYZONE",
	"zone : tZONE tDST",
	"day : tDAY",
	"day : tDAY ','",
	"day : tUNUMBER tDAY",
	"date : tUNUMBER '/' tUNUMBER",
	"date : tUNUMBER '/' tUNUMBER '/' tUNUMBER",
	"date : tUNUMBER tSNUMBER tSNUMBER",
	"date : tMONTH tUNUMBER",
	"date : tMONTH tUNUMBER ',' tUNUMBER",
	"date : tUNUMBER tMONTH",
	"date : tUNUMBER tMONTH tUNUMBER",
	"rel : relunit tAGO",
	"rel : relunit",
	"relunit : tUNUMBER tMINUTE_UNIT",
	"relunit : tSNUMBER tMINUTE_UNIT",
	"relunit : tMINUTE_UNIT",
	"relunit : tSNUMBER tSEC_UNIT",
	"relunit : tUNUMBER tSEC_UNIT",
	"relunit : tSEC_UNIT",
	"relunit : tSNUMBER tMONTH_UNIT",
	"relunit : tUNUMBER tMONTH_UNIT",
	"relunit : tMONTH_UNIT",
	"number : tUNUMBER",
	"o_merid : /* empty */",
	"o_merid : tMERIDIAN",
};
#endif /* this_YYDEBUG */
#line 1 "/usr/lib/yaccpar"
/*	@(#)yaccpar 1.10 89/04/04 SMI; from S5R3 1.10	*/

/*
** Skeleton parser driver for yacc output
*/

/*
** yacc user known macros and defines
*/
#define this_YYERROR		goto THIS_yyerrlab
#define this_YYACCEPT	{ free(THIS_yys); free(THIS_yyv); return(0); }
#define this_YYABORT		{ free(THIS_yys); free(THIS_yyv); return(1); }
#define this_YYBACKUP( newtoken, newvalue )\
{\
	if ( THIS_yychar >= 0 || ( THIS_yyr2[ THIS_yytmp ] >> 1 ) != 1 )\
	{\
		THIS_yyerror( "syntax error - cannot backup" );\
		goto THIS_yyerrlab;\
	}\
	THIS_yychar = newtoken;\
	THIS_yystate = *THIS_yyps;\
	THIS_yylval = newvalue;\
	goto THIS_yynewstate;\
}
#define this_YYRECOVERING()	(!!THIS_yyerrflag)
#ifndef this_YYDEBUG
#	define this_YYDEBUG	1	/* make debugging available */
#endif

/*
** user known globals
*/
int THIS_yydebug;			/* set to 1 to get debugging */

/*
** driver internal defines
*/
#define this_YYFLAG		(-1000)

/*
** static variables used by the parser
*/
static this_YYSTYPE *THIS_yyv;			/* value stack */
static int *THIS_yys;			/* state stack */

static this_YYSTYPE *THIS_yypv;			/* top of value stack */
static int *THIS_yyps;			/* top of state stack */

static int THIS_yystate;			/* current state */
static int THIS_yytmp;			/* extra var (lasts between blocks) */

int THIS_yynerrs;			/* number of errors */

int THIS_yyerrflag;			/* error recovery flag */
int THIS_yychar;			/* current input token number */


/*
** THIS_yyparse - return 0 if worked, 1 if syntax error not recovered from
*/
int
THIS_yyparse()
{
	register this_YYSTYPE *THIS_yypvt;	/* top of value stack for $vars */
	unsigned THIS_yymaxdepth = this_YYMAXDEPTH;

	/*
	** Initialize externals - THIS_yyparse may be called more than once
	*/
	THIS_yyv = (this_YYSTYPE*)malloc(THIS_yymaxdepth*sizeof(this_YYSTYPE));
	THIS_yys = (int*)malloc(THIS_yymaxdepth*sizeof(int));
	if (!THIS_yyv || !THIS_yys)
	{
		THIS_yyerror( "out of memory" );
		return(1);
	}
	THIS_yypv = &THIS_yyv[-1];
	THIS_yyps = &THIS_yys[-1];
	THIS_yystate = 0;
	THIS_yytmp = 0;
	THIS_yynerrs = 0;
	THIS_yyerrflag = 0;
	THIS_yychar = -1;

	goto THIS_yystack;
	{
		register this_YYSTYPE *THIS_yy_pv;	/* top of value stack */
		register int *THIS_yy_ps;		/* top of state stack */
		register int THIS_yy_state;		/* current state */
		register int  THIS_yy_n;		/* internal state number info */

		/*
		** get globals into registers.
		** branch to here only if this_YYBACKUP was called.
		*/
	THIS_yynewstate:
		THIS_yy_pv = THIS_yypv;
		THIS_yy_ps = THIS_yyps;
		THIS_yy_state = THIS_yystate;
		goto THIS_yy_newstate;

		/*
		** get globals into registers.
		** either we just started, or we just finished a reduction
		*/
	THIS_yystack:
		THIS_yy_pv = THIS_yypv;
		THIS_yy_ps = THIS_yyps;
		THIS_yy_state = THIS_yystate;

		/*
		** top of for (;;) loop while no reductions done
		*/
	THIS_yy_stack:
		/*
		** put a state and value onto the stacks
		*/
#if this_YYDEBUG
		/*
		** if debugging, look up token value in list of value vs.
		** name pairs.  0 and negative (-1) are special values.
		** Note: linear search is used since time is not a real
		** consideration while debugging.
		*/
		if ( THIS_yydebug )
		{
			register int THIS_yy_i;

			(void)printf( "State %d, token ", THIS_yy_state );
			if ( THIS_yychar == 0 )
				(void)printf( "end-of-file\n" );
			else if ( THIS_yychar < 0 )
				(void)printf( "-none-\n" );
			else
			{
				for ( THIS_yy_i = 0; THIS_yytoks[THIS_yy_i].t_val >= 0;
					THIS_yy_i++ )
				{
					if ( THIS_yytoks[THIS_yy_i].t_val == THIS_yychar )
						break;
				}
				(void)printf( "%s\n", THIS_yytoks[THIS_yy_i].t_name );
			}
		}
#endif /* this_YYDEBUG */
		if ( ++THIS_yy_ps >= &THIS_yys[ THIS_yymaxdepth ] )	/* room on stack? */
		{
			/*
			** reallocate and recover.  Note that pointers
			** have to be reset, or bad things will happen
			*/
			int THIS_yyps_index = (THIS_yy_ps - THIS_yys);
			int THIS_yypv_index = (THIS_yy_pv - THIS_yyv);
			int THIS_yypvt_index = (THIS_yypvt - THIS_yyv);
			THIS_yymaxdepth += this_YYMAXDEPTH;
			THIS_yyv = (this_YYSTYPE*)realloc((char*)THIS_yyv,
				THIS_yymaxdepth * sizeof(this_YYSTYPE));
			THIS_yys = (int*)realloc((char*)THIS_yys,
				THIS_yymaxdepth * sizeof(int));
			if (!THIS_yyv || !THIS_yys)
			{
				THIS_yyerror( "yacc stack overflow" );
				return(1);
			}
			THIS_yy_ps = THIS_yys + THIS_yyps_index;
			THIS_yy_pv = THIS_yyv + THIS_yypv_index;
			THIS_yypvt = THIS_yyv + THIS_yypvt_index;
		}
		*THIS_yy_ps = THIS_yy_state;
		*++THIS_yy_pv = THIS_yyval;

		/*
		** we have a new state - find out what to do
		*/
	THIS_yy_newstate:
		if ( ( THIS_yy_n = THIS_yypact[ THIS_yy_state ] ) <= this_YYFLAG )
			goto THIS_yydefault;		/* simple state */
#if this_YYDEBUG
		/*
		** if debugging, need to mark whether new token grabbed
		*/
		THIS_yytmp = THIS_yychar < 0;
#endif
		if ( ( THIS_yychar < 0 ) && ( ( THIS_yychar = THIS_yylex() ) < 0 ) )
			THIS_yychar = 0;		/* reached EOF */
#if this_YYDEBUG
		if ( THIS_yydebug && THIS_yytmp )
		{
			register int THIS_yy_i;

			(void)printf( "Received token " );
			if ( THIS_yychar == 0 )
				(void)printf( "end-of-file\n" );
			else if ( THIS_yychar < 0 )
				(void)printf( "-none-\n" );
			else
			{
				for ( THIS_yy_i = 0; THIS_yytoks[THIS_yy_i].t_val >= 0;
					THIS_yy_i++ )
				{
					if ( THIS_yytoks[THIS_yy_i].t_val == THIS_yychar )
						break;
				}
				(void)printf( "%s\n", THIS_yytoks[THIS_yy_i].t_name );
			}
		}
#endif /* this_YYDEBUG */
		if ( ( ( THIS_yy_n += THIS_yychar ) < 0 ) || ( THIS_yy_n >= this_YYLAST ) )
			goto THIS_yydefault;
		if ( THIS_yychk[ THIS_yy_n = THIS_yyact[ THIS_yy_n ] ] == THIS_yychar )	/*valid shift*/
		{
			THIS_yychar = -1;
			THIS_yyval = THIS_yylval;
			THIS_yy_state = THIS_yy_n;
			if ( THIS_yyerrflag > 0 )
				THIS_yyerrflag--;
			goto THIS_yy_stack;
		}

	THIS_yydefault:
		if ( ( THIS_yy_n = THIS_yydef[ THIS_yy_state ] ) == -2 )
		{
#if this_YYDEBUG
			THIS_yytmp = THIS_yychar < 0;
#endif
			if ( ( THIS_yychar < 0 ) && ( ( THIS_yychar = THIS_yylex() ) < 0 ) )
				THIS_yychar = 0;		/* reached EOF */
#if this_YYDEBUG
			if ( THIS_yydebug && THIS_yytmp )
			{
				register int THIS_yy_i;

				(void)printf( "Received token " );
				if ( THIS_yychar == 0 )
					(void)printf( "end-of-file\n" );
				else if ( THIS_yychar < 0 )
					(void)printf( "-none-\n" );
				else
				{
					for ( THIS_yy_i = 0;
						THIS_yytoks[THIS_yy_i].t_val >= 0;
						THIS_yy_i++ )
					{
						if ( THIS_yytoks[THIS_yy_i].t_val
							== THIS_yychar )
						{
							break;
						}
					}
					(void)printf( "%s\n", THIS_yytoks[THIS_yy_i].t_name );
				}
			}
#endif /* this_YYDEBUG */
			/*
			** look through exception table
			*/
			{
				register int *THIS_yyxi = THIS_yyexca;

				while ( ( *THIS_yyxi != -1 ) ||
					( THIS_yyxi[1] != THIS_yy_state ) )
				{
					THIS_yyxi += 2;
				}
				while ( ( *(THIS_yyxi += 2) >= 0 ) &&
					( *THIS_yyxi != THIS_yychar ) )
					;
				if ( ( THIS_yy_n = THIS_yyxi[1] ) < 0 )
					this_YYACCEPT;
			}
		}

		/*
		** check for syntax error
		*/
		if ( THIS_yy_n == 0 )	/* have an error */
		{
			/* no worry about speed here! */
			switch ( THIS_yyerrflag )
			{
			case 0:		/* new error */
				THIS_yyerror( "syntax error" );
				goto skip_init;
			THIS_yyerrlab:
				/*
				** get globals into registers.
				** we have a user generated syntax type error
				*/
				THIS_yy_pv = THIS_yypv;
				THIS_yy_ps = THIS_yyps;
				THIS_yy_state = THIS_yystate;
				THIS_yynerrs++;
			skip_init:
			case 1:
			case 2:		/* incompletely recovered error */
					/* try again... */
				THIS_yyerrflag = 3;
				/*
				** find state where "error" is a legal
				** shift action
				*/
				while ( THIS_yy_ps >= THIS_yys )
				{
					THIS_yy_n = THIS_yypact[ *THIS_yy_ps ] + this_YYERRCODE;
					if ( THIS_yy_n >= 0 && THIS_yy_n < this_YYLAST &&
						THIS_yychk[THIS_yyact[THIS_yy_n]] == this_YYERRCODE)					{
						/*
						** simulate shift of "error"
						*/
						THIS_yy_state = THIS_yyact[ THIS_yy_n ];
						goto THIS_yy_stack;
					}
					/*
					** current state has no shift on
					** "error", pop stack
					*/
#if this_YYDEBUG
#	define _POP_ "Error recovery pops state %d, uncovers state %d\n"
					if ( THIS_yydebug )
						(void)printf( _POP_, *THIS_yy_ps,
							THIS_yy_ps[-1] );
#	undef _POP_
#endif
					THIS_yy_ps--;
					THIS_yy_pv--;
				}
				/*
				** there is no state on stack with "error" as
				** a valid shift.  give up.
				*/
				this_YYABORT;
			case 3:		/* no shift yet; eat a token */
#if this_YYDEBUG
				/*
				** if debugging, look up token in list of
				** pairs.  0 and negative shouldn't occur,
				** but since timing doesn't matter when
				** debugging, it doesn't hurt to leave the
				** tests here.
				*/
				if ( THIS_yydebug )
				{
					register int THIS_yy_i;

					(void)printf( "Error recovery discards " );
					if ( THIS_yychar == 0 )
						(void)printf( "token end-of-file\n" );
					else if ( THIS_yychar < 0 )
						(void)printf( "token -none-\n" );
					else
					{
						for ( THIS_yy_i = 0;
							THIS_yytoks[THIS_yy_i].t_val >= 0;
							THIS_yy_i++ )
						{
							if ( THIS_yytoks[THIS_yy_i].t_val
								== THIS_yychar )
							{
								break;
							}
						}
						(void)printf( "token %s\n",
							THIS_yytoks[THIS_yy_i].t_name );
					}
				}
#endif /* this_YYDEBUG */
				if ( THIS_yychar == 0 )	/* reached EOF. quit */
					this_YYABORT;
				THIS_yychar = -1;
				goto THIS_yy_newstate;
			}
		}/* end if ( THIS_yy_n == 0 ) */
		/*
		** reduction by production THIS_yy_n
		** put stack tops, etc. so things right after switch
		*/
#if this_YYDEBUG
		/*
		** if debugging, print the string that is the user's
		** specification of the reduction which is just about
		** to be done.
		*/
		if ( THIS_yydebug )
			(void)printf( "Reduce by (%d) \"%s\"\n",
				THIS_yy_n, THIS_yyreds[ THIS_yy_n ] );
#endif
		THIS_yytmp = THIS_yy_n;			/* value to switch over */
		THIS_yypvt = THIS_yy_pv;			/* $vars top of value stack */
		/*
		** Look in goto table for next state
		** Sorry about using THIS_yy_state here as temporary
		** register variable, but why not, if it works...
		** If THIS_yyr2[ THIS_yy_n ] doesn't have the low order bit
		** set, then there is no action to be done for
		** this reduction.  So, no saving & unsaving of
		** registers done.  The only difference between the
		** code just after the if and the body of the if is
		** the goto THIS_yy_stack in the body.  This way the test
		** can be made before the choice of what to do is needed.
		*/
		{
			/* length of production doubled with extra bit */
			register int THIS_yy_len = THIS_yyr2[ THIS_yy_n ];

			if ( !( THIS_yy_len & 01 ) )
			{
				THIS_yy_len >>= 1;
				THIS_yyval = ( THIS_yy_pv -= THIS_yy_len )[1];	/* $$ = $1 */
				THIS_yy_state = THIS_yypgo[ THIS_yy_n = THIS_yyr1[ THIS_yy_n ] ] +
					*( THIS_yy_ps -= THIS_yy_len ) + 1;
				if ( THIS_yy_state >= this_YYLAST ||
					THIS_yychk[ THIS_yy_state =
					THIS_yyact[ THIS_yy_state ] ] != -THIS_yy_n )
				{
					THIS_yy_state = THIS_yyact[ THIS_yypgo[ THIS_yy_n ] ];
				}
				goto THIS_yy_stack;
			}
			THIS_yy_len >>= 1;
			THIS_yyval = ( THIS_yy_pv -= THIS_yy_len )[1];	/* $$ = $1 */
			THIS_yy_state = THIS_yypgo[ THIS_yy_n = THIS_yyr1[ THIS_yy_n ] ] +
				*( THIS_yy_ps -= THIS_yy_len ) + 1;
			if ( THIS_yy_state >= this_YYLAST ||
				THIS_yychk[ THIS_yy_state = THIS_yyact[ THIS_yy_state ] ] != -THIS_yy_n )
			{
				THIS_yy_state = THIS_yyact[ THIS_yypgo[ THIS_yy_n ] ];
			}
		}
					/* save until reenter driver code */
		THIS_yystate = THIS_yy_state;
		THIS_yyps = THIS_yy_ps;
		THIS_yypv = THIS_yy_pv;
	}
	/*
	** code supplied by user is placed in this switch
	*/
	switch( THIS_yytmp )
	{
		
case 3:
# line 233 "getdate.y"
{
	    THIS_yyHaveTime++;
	} break;
case 4:
# line 236 "getdate.y"
{
	    THIS_yyHaveZone++;
	} break;
case 5:
# line 239 "getdate.y"
{
	    THIS_yyHaveDate++;
	} break;
case 6:
# line 242 "getdate.y"
{
	    THIS_yyHaveDay++;
	} break;
case 7:
# line 245 "getdate.y"
{
	    THIS_yyHaveRel++;
	} break;
case 9:
# line 251 "getdate.y"
{
	    THIS_yyHour = THIS_yypvt[-1].Number;
	    THIS_yyMinutes = 0;
	    THIS_yySeconds = 0;
	    THIS_yyMeridian = THIS_yypvt[-0].Meridian;
	} break;
case 10:
# line 257 "getdate.y"
{
	    THIS_yyHour = THIS_yypvt[-3].Number;
	    THIS_yyMinutes = THIS_yypvt[-1].Number;
	    THIS_yySeconds = 0;
	    THIS_yyMeridian = THIS_yypvt[-0].Meridian;
	} break;
case 11:
# line 263 "getdate.y"
{
	    THIS_yyHour = THIS_yypvt[-3].Number;
	    THIS_yyMinutes = THIS_yypvt[-1].Number;
	    THIS_yyMeridian = MER24;
	    THIS_yyDSTmode = DSToff;
	    THIS_yyTimezone = - (THIS_yypvt[-0].Number % 100 + (THIS_yypvt[-0].Number / 100) * 60);
	} break;
case 12:
# line 270 "getdate.y"
{
	    THIS_yyHour = THIS_yypvt[-5].Number;
	    THIS_yyMinutes = THIS_yypvt[-3].Number;
	    THIS_yySeconds = THIS_yypvt[-1].Number;
	    THIS_yyMeridian = THIS_yypvt[-0].Meridian;
	} break;
case 13:
# line 276 "getdate.y"
{
	    THIS_yyHour = THIS_yypvt[-5].Number;
	    THIS_yyMinutes = THIS_yypvt[-3].Number;
	    THIS_yySeconds = THIS_yypvt[-1].Number;
	    THIS_yyMeridian = MER24;
	    THIS_yyDSTmode = DSToff;
	    THIS_yyTimezone = - (THIS_yypvt[-0].Number % 100 + (THIS_yypvt[-0].Number / 100) * 60);
	} break;
case 14:
# line 286 "getdate.y"
{
	    THIS_yyTimezone = THIS_yypvt[-0].Number;
	    THIS_yyDSTmode = DSToff;
	} break;
case 15:
# line 290 "getdate.y"
{
	    THIS_yyTimezone = THIS_yypvt[-0].Number;
	    THIS_yyDSTmode = DSTon;
	} break;
case 16:
# line 295 "getdate.y"
{
	    THIS_yyTimezone = THIS_yypvt[-1].Number;
	    THIS_yyDSTmode = DSTon;
	} break;
case 17:
# line 301 "getdate.y"
{
	    THIS_yyDayOrdinal = 1;
	    THIS_yyDayNumber = THIS_yypvt[-0].Number;
	} break;
case 18:
# line 305 "getdate.y"
{
	    THIS_yyDayOrdinal = 1;
	    THIS_yyDayNumber = THIS_yypvt[-1].Number;
	} break;
case 19:
# line 309 "getdate.y"
{
	    THIS_yyDayOrdinal = THIS_yypvt[-1].Number;
	    THIS_yyDayNumber = THIS_yypvt[-0].Number;
	} break;
case 20:
# line 315 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-2].Number;
	    THIS_yyDay = THIS_yypvt[-0].Number;
	} break;
case 21:
# line 319 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-4].Number;
	    THIS_yyDay = THIS_yypvt[-2].Number;
	    THIS_yyYear = THIS_yypvt[-0].Number;
	} break;
case 22:
# line 324 "getdate.y"
{
	    /* ISO 8601 format.  THIS_yyTHIS_yy-mm-dd.  */
	    THIS_yyYear = THIS_yypvt[-2].Number;
	    THIS_yyMonth = -THIS_yypvt[-1].Number;
	    THIS_yyDay = -THIS_yypvt[-0].Number;
	} break;
case 23:
# line 330 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-1].Number;
	    THIS_yyDay = THIS_yypvt[-0].Number;
	} break;
case 24:
# line 334 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-3].Number;
	    THIS_yyDay = THIS_yypvt[-2].Number;
	    THIS_yyYear = THIS_yypvt[-0].Number;
	} break;
case 25:
# line 339 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-0].Number;
	    THIS_yyDay = THIS_yypvt[-1].Number;
	} break;
case 26:
# line 343 "getdate.y"
{
	    THIS_yyMonth = THIS_yypvt[-1].Number;
	    THIS_yyDay = THIS_yypvt[-2].Number;
	    THIS_yyYear = THIS_yypvt[-0].Number;
	} break;
case 27:
# line 350 "getdate.y"
{
	    THIS_yyRelSeconds = -THIS_yyRelSeconds;
	    THIS_yyRelMonth = -THIS_yyRelMonth;
	} break;
case 29:
# line 357 "getdate.y"
{
	    THIS_yyRelSeconds += THIS_yypvt[-1].Number * THIS_yypvt[-0].Number * 60L;
	} break;
case 30:
# line 360 "getdate.y"
{
	    THIS_yyRelSeconds += THIS_yypvt[-1].Number * THIS_yypvt[-0].Number * 60L;
	} break;
case 31:
# line 363 "getdate.y"
{
	    THIS_yyRelSeconds += THIS_yypvt[-0].Number * 60L;
	} break;
case 32:
# line 366 "getdate.y"
{
	    THIS_yyRelSeconds += THIS_yypvt[-1].Number;
	} break;
case 33:
# line 369 "getdate.y"
{
	    THIS_yyRelSeconds += THIS_yypvt[-1].Number;
	} break;
case 34:
# line 372 "getdate.y"
{
	    THIS_yyRelSeconds++;
	} break;
case 35:
# line 375 "getdate.y"
{
	    THIS_yyRelMonth += THIS_yypvt[-1].Number * THIS_yypvt[-0].Number;
	} break;
case 36:
# line 378 "getdate.y"
{
	    THIS_yyRelMonth += THIS_yypvt[-1].Number * THIS_yypvt[-0].Number;
	} break;
case 37:
# line 381 "getdate.y"
{
	    THIS_yyRelMonth += THIS_yypvt[-0].Number;
	} break;
case 38:
# line 386 "getdate.y"
{
	    if (THIS_yyHaveTime && THIS_yyHaveDate && !THIS_yyHaveRel)
		THIS_yyYear = THIS_yypvt[-0].Number;
	    else {
		if(THIS_yypvt[-0].Number>10000) {
		    time_t date_part;

		    date_part= THIS_yypvt[-0].Number/10000;
		    THIS_yyHaveDate++;
		    THIS_yyDay= (date_part)%100;
		    THIS_yyMonth= (date_part/100)%100;
		    THIS_yyYear = date_part/10000;
		} 
	        THIS_yyHaveTime++;
		if (THIS_yypvt[-0].Number < 100) {
		    THIS_yyHour = THIS_yypvt[-0].Number;
		    THIS_yyMinutes = 0;
		}
		else {
		    THIS_yyHour = THIS_yypvt[-0].Number / 100;
		    THIS_yyMinutes = THIS_yypvt[-0].Number % 100;
		}
		THIS_yySeconds = 0;
		THIS_yyMeridian = MER24;
	    }
	} break;
case 39:
# line 414 "getdate.y"
{
	    THIS_yyval.Meridian = MER24;
	} break;
case 40:
# line 417 "getdate.y"
{
	    THIS_yyval.Meridian = THIS_yypvt[-0].Meridian;
	} break;
	}
	goto THIS_yystack;		/* reset registers in driver code */
}
