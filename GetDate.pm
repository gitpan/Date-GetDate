package Date::GetDate;

require Exporter;
require DynaLoader;
use vars qw(@ISA @EXPORT $VERSION);
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw( getdate );
$VERSION = "2.00";

sub getdate { &salz_getdate }

bootstrap Date::GetDate;
1;
