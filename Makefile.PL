# This -*- perl -*- script makes the Makefile
# $Id: Makefile.PL,v 1.2 1995/12/18 15:36:18 gbarr Exp gbarr $

use ExtUtils::MakeMaker;
use ExtUtils::Manifest qw(maniread);

#--- Configuration section ---

#--- End User Configuration - You should not have to change anything below this line

require 5.001;

require "./GetDate.pm";

$VERSION  = Date::GetDate->Version();
$NAME     = 'Date::GetDate';
#$DISTNAME = 'MailTools';

#--- End Configuration

sub initialize {
 local($_);

 my $manifest = maniread();

 my %pl_files = ();
 my @exe_files = ();

 foreach (keys %$manifest) {
  $pl_files{$_} = $1 if(/(.*)\.PL\Z/ && !/^Makefile.PL$/);
  push(@exe_files,$_) if(m#\bbin/# && !m#demo#);
 }

 %hash = (
	VERSION   => $VERSION,
	NAME      => $NAME,
#	DISTNAME  => $DISTNAME,
	SKIP      => [qw(static dynamic)],
	PL_FILES  => \%pl_files,
	EXE_FILES => \@exe_files,
	dist      => {COMPRESS     => 'gzip -9f',
		      SUFFIX       => 'gz',
		      DIST_DEFAULT => 'all tardist',
		      CI           => 'ci -l'
		     },
	linkext   => {LINKTYPE => ''},
	clean     => {FILES => '*% *.html *.bak *.old lib/*% lib/*/*% $(EXE_FILES)'},
 );

 \%hash;
}

sub MY::test {
    q{
TEST_VERBOSE=0

test:
	$(FULLPERL) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use Test::Harness qw(&runtests $$verbose); $$verbose=$(TEST_VERBOSE); runtests @ARGV;' t/*.t

};
}

sub MY::libscan {
    return '' if m:/(RCS|CVS)/:;
    return '' if m/[~%]$/;
    return '' if m/\.(orig|rej)$/;
    $_;
}

sub MY::postamble {
'
GetDate.pm : GetDate.y
	byacc -b GetDate -P GetDate.y
	mv GetDate.tab.pl GetDate.pm
'
}



# -- Make the Makefile

die "You require MakeMaker v4.17 or later to install this package\n"
   unless($ExtUtils::MakeMaker::Version >= 4.17);

WriteMakefile(CONFIGURE => \&initialize);
__END__
use ExtUtils::MakeMaker;

require "./GetDate.pm";

WriteMakefile( VERSION => scalar Date::GetDate->Version,
               NAME    => 'Date::GetDate',
              'LINKTYPE' => '',
               DIR     => [],
              'dist'      => { SUFFIX => 'gz', COMPRESS => 'gzip -f' },
               'clean' => {FILES => "*%"}
             );

sub MY::xtest {
'

test: $(INST_PM)
	$(FULLPERL) tst

'
}

sub MY::test {
    q{
TEST_VERBOSE=0

test:
	$(FULLPERL) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -e 'use Test::Harness qw(&runtests $$verbose); $$verbose=$(TEST_VERBOSE); runtests @ARGV;' t/*.t

};
}

sub MY::post_constants {
'
OBJECT = 
.SUFFIXES: .xs
';
}



