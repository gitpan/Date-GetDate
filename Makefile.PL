use ExtUtils::MakeMaker;
WriteMakefile(
	'NAME'		=> 'Date::GetDate',
	'DISTNAME'      => 'Date-GetDate',
	'VERSION_FROM'	=> 'GetDate.pm',
	'dist' => { COMPRESS => 'gzip --best' },
);
