use ExtUtils::MakeMaker;

WriteMakefile( VERSION => '0.01a' , 
               NAME => 'Date::GetDate',
               'clean' => {FILES => "*%"}
             );

sub MY::test {
'
test: GetDate.pm
	$(FULLPERL) tst
'
}

sub MY::post_initialize {
 $ExtUtils::MakeMaker::att{PM} = { 'GetDate.pm' => '$(INST_LIBDIR)/GetDate.pm'};
 $ExtUtils::MakeMaker::att{PM} = { 'CTime.pm' => '$(INST_LIBDIR)/CTime.pm'};
 '';
}
sub MY::install {
'
install: $(INST_PM)
'
}

sub MY::linkext { 'linkext: GetDate.pm' }

sub MY::postamble {
'
config: Makefile   

GetDate.pm   : GetDate.y
	byacc -P -b GetDate GetDate.y
	mv GetDate.tab.pl GetDate.pm
'
}


