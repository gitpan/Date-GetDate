#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
/* #include <sys/timeb.h> */

#include "./getdate.c"

typedef struct timeb TimeB;

MODULE = Date::GetDate	PACKAGE = Date::GetDate

int
salz_getdate(datestr, now=0)
    char *		datestr
    TimeB *		now
