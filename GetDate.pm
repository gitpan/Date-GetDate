package Date::GetDate;

require Exporter;
require DynaLoader;
use vars qw(@ISA @EXPORT $VERSION);
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw( getdate );
$VERSION = "2.01";
warn "Date::GetDate needs Date::Parse for dates in the third millennium";

sub getdate {
  my($ret);
  if (($ret = &salz_getdate) < 0) {
    require Date::Parse;
    return &Date::Parse::str2time;
  } else {
    return $ret;
  }
}

bootstrap Date::GetDate;
1;
