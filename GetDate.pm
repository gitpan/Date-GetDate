package Date::GetDate;

require Exporter;
require DynaLoader;
use vars qw(@ISA @EXPORT $VERSION);
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw( getdate );
$VERSION = "2.02";
eval { require Date::Parse };
warn "WARNING: Date::GetDate requires" .
    " Date::Parse for years >= 2000" if $@;

sub getdate {
  my($ret);
  if (($ret = &salz_getdate) < 0) {
    require Date::Parse; # retry if they installed it in the meantime
    return &Date::Parse::str2time;
  } else {
    return $ret;
  }
}

bootstrap Date::GetDate;
1;
