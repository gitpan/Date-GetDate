#!/usr/local/bin/perl -w

#Thanks to Graham Barr for writing these tests. Slightly adjusted for
#the C version by Andreas Koenig, 96-06-08.

use Date::GetDate;

# if those two are available, we'll run an extended test
eval {
    require Benchmark;
    require Date::Parse;
    require Time::ParseDate;
};
unless ($@) {
    $extended_test = 1;
}

$data = qq!Wed, 16 Jun 94 07:29:35 CST    	     ;771773375
Wed, 16 Nov 94 07:29:35 CST 	     ;784992575
Mon, 21 Nov 94 07:42:23 CST 	     ;785425343
Mon, 21 Nov 94 04:28:18 CST 	     ;785413698
Tue, 15 Nov 94 09:15:10 GMT 	     ;784890910
Wed, 16 Nov 94 09:39:49 GMT 	     ;784978789
Wed, 16 Nov 94 09:23:17 GMT 	     ;784977797
Wed, 16 Nov 94 12:39:49 GMT 	     ;784989589
Wed, 16 Nov 94 14:03:06 GMT 	     ;784994586
Wed, 16 Nov 94 05:30:51 CST 	     ;784985451
Thu, 17 Nov 94 03:19:30 CST 	     ;785063970
Mon, 21 Nov 94 14:05:32 GMT 	     ;785426732
Mon, 14 Nov 94 15:08:49 CST 	     ;784847329
Wed, 16 Nov 94 14:48:06 GMT 	     ;784997286
Thu, 17 Nov 94 14:22:03 GMT 	     ;785082123
Wed, 16 Nov 94 14:36:00 GMT 	     ;784996560
Wed, 16 Nov 94 09:23:17 GMT 	     ;784977797
Wed, 16 Nov 94 10:01:43 GMT 	     ;784980103
Wed, 16 Nov 94 15:03:35 GMT 	     ;784998215
Mon, 21 Nov 94 13:55:19 GMT 	     ;785426119
Wed, 16 Nov 94 08:46:11 CST 	     ;784997171
Wed, 9 Nov 1994 09:50:32 -0500 (EST) ;784392632
Thu, 13 Oct 94 10:13:13 -0700	     ;782068393
Sat, 19 Nov 1994 16:59:14 +0100      ;785260754
Thu, 3 Nov 94 14:10:47 EST 	     ;783889847
Thu, 3 Nov 94 21:51:09 EST 	     ;783917469
Fri, 4 Nov 94 9:24:52 EST 	     ;783959092
Wed, 9 Nov 94 09:38:54 EST 	     ;784391934
Mon, 14 Nov 94 13:20:12 EST 	     ;784837212
Wed, 16 Nov 94 17:09:13 EST 	     ;785023753
Tue, 15 Nov 94 12:27:01 PST 	     ;784931221
Fri, 18 Nov 1994 07:34:05 -0600      ;785165645
Mon, 21 Nov 94 14:34:28 -0500 	     ;785446468
Fri, 18 Nov 1994 12:05:47 -0800 (PST);785189147
Fri, 18 Nov 1994 12:36:26 -0800 (PST);785190986
Wed, 16 Nov 1994 15:58:58 GMT 	     ;785001538
Sun, 06 Nov 94 14:27:40 -0500 	     ;784150060
Mon, 07 Nov 94 08:20:13 -0500 	     ;784214413
Mon, 07 Nov 94 16:48:42 -0500 	     ;784244922
Wed, 09 Nov 94 15:46:16 -0500 	     ;784413976
Sun, 6 Nov 1994 02:38:17 -0800 	     ;784118297
Tue, 1 Nov 1994 13:53:49 -0500 	     ;783716029
Tue, 15 Nov 94 08:31:59 +0100 	     ;784884719
Sun, 6 Nov 1994 11:09:12 -0500 (IST) ;784138152
Fri, 4 Nov 94 12:52:10 EST 	     ;783971530
Mon, 31 Oct 1994 14:17:39 -0500 (EST);783631059
Mon, 14 Nov 94 11:25:00 CST 	     ;784833900
Mon, 14 Nov 94 13:26:29 CST 	     ;784841189
Fri, 18 Nov 94 8:42:47 CST 	     ;785169767
Thu, 17 Nov 94 14:32:01 +0900 	     ;785050321
Wed, 2 Nov 94 18:16:31 +0100 	     ;783796591
Fri, 18 Nov 94 10:46:26 +0100 	     ;785151986
Tue, 8 Nov 1994 22:39:28 +0200 	     ;784327168
Wed, 16 Nov 1994 10:01:08 -0500 (EST);784998068
Wed, 2 Nov 1994 16:59:42 -0800 	     ;783824382
Wed, 9 Nov 94 10:00:23 PST 	     ;784404023
Fri, 18 Nov 94 17:01:43 PST 	     ;785206903
Mon, 14 Nov 1994 14:47:46 -0500      ;784842466
Mon, 21 Nov 1994 04:56:04 -0500 (EST);785411764
Mon, 21 Nov 1994 11:50:12 -0800      ;785447412
Sat, 5 Nov 1994 14:04:16 -0600 (CST) ;784065856
Sat, 05 Nov 94 13:10:13 MST 	     ;784066213
Wed, 02 Nov 94 10:47:48 -0800 	     ;783802068
Wed, 02 Nov 94 13:19:15 -0800 	     ;783811155
Thu, 03 Nov 94 15:27:07 -0800 	     ;783905227
Fri, 04 Nov 94 09:12:12 -0800 	     ;783969132
Wed, 9 Nov 1994 10:13:03 +0000 (GMT) ;784375983
Wed, 9 Nov 1994 15:28:37 +0000 (GMT) ;784394917
Wed, 2 Nov 1994 17:37:41 +0100 (MET) ;783794261
05 Nov 94 14:22:19 PST 		     ;784074139
16 Nov 94 22:28:20 PST 		     ;785053700
Tue, 1 Nov 1994 19:51:15 -0800 	     ;783748275
Wed, 2 Nov 94 12:21:23 GMT 	     ;783778883
Fri, 18 Nov 94 18:07:03 GMT 	     ;785182023
Wed, 16 Nov 1994 11:26:27 -0500      ;785003187
Sun, 6 Nov 1994 13:48:49 -0500 	     ;784147729
Tue, 8 Nov 1994 13:19:37 -0800 	     ;784329577
Fri, 18 Nov 1994 11:01:12 -0800      ;785185272
Mon, 21 Nov 1994 00:47:58 -0500      ;785396878
Mon, 7 Nov 1994 14:22:48 -0800 (PST) ;784246968
Wed, 16 Nov 1994 15:56:45 -0800 (PST);785030205
Thu, 3 Nov 1994 13:17:47 +0000 	     ;783868667
Wed, 9 Nov 1994 17:32:50 -0500 (EST) ;784420370
Wed, 9 Nov 94 16:31:52 PST	     ;784427512
Wed, 09 Nov 94 10:41:10 -0800	     ;784406470
Wed, 9 Nov 94 08:42:22 MST	     ;784395742
Mon, 14 Nov 1994 08:32:13 -0800	     ;784830733
Mon, 14 Nov 1994 11:34:32 -0500 (EST);784830872
Mon, 14 Nov 94 16:48:09 GMT	     ;784831689
Tue, 15 Nov 1994 10:27:33 +0000      ;784895253
Wed, 02 Nov 94 13:56:54 MST 	     ;783809814
Thu, 03 Nov 94 15:24:45 MST 	     ;783901485
Thu, 3 Nov 1994 15:13:53 -0700 (MST) ;783900833
Fri, 04 Nov 94 08:15:13 MST 	     ;783962113
Thu, 3 Nov 94 18:15:47 EST	     ;783904547
Tue, 08 Nov 94 07:02:33 MST 	     ;784303353
Thu, 3 Nov 94 18:15:47 EST	     ;783904547
Tue, 15 Nov 94 07:26:05 MST 	     ;784909565
Wed, 2 Nov 1994 00:00:55 -0600 (CST) ;783756055
Sun, 6 Nov 1994 01:19:13 -0600 (CST) ;784106353
Mon, 7 Nov 1994 23:16:57 -0600 (CST) ;784271817
Tue, 08 Nov 1994 13:21:21 -0600	     ;784322481
Mon, 07 Nov 94 13:47:37 PST          ;784244857
Tue, 08 Nov 94 11:23:19 PST 	     ;784322599
Tue, 01 Nov 1994 11:28:25 -0800      ;783718105
Tue, 15 Nov 1994 13:11:47 -0800      ;784933907
Tue, 15 Nov 1994 13:18:38 -0800      ;784934318
Tue, 15 Nov 1994 0:18:38 -0800 	     ;784887518
Sun Mar 18 03:51:58 2001 GMT	     ;984887518
!;

@data = split(/\n/, $data);

print "1..", scalar(@data),"\n";
$loop = 1;

foreach (@data){
    my($str,$time_expect) = split ';', $_;
    $time = getdate($str);

    if(defined $time && $time==$time_expect) {
	if ($extended_test) {
	    if (Date::Parse::str2time($str)==$time_expect && Time::ParseDate::parsedate($str)==$time_expect) {
		print "ok $loop +\n";
	    } else {
		print "FAIL $loop +\n";
	    }
	} else {
	    print "ok $loop\n";
	}
    } else {
	print "FAIL $loop\n";
    }

    $loop++;
}

