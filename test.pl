# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Text::TeX;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

sub readfile {
  my $file = new Text::TeX::OpenFile 'test.tex', 'defaultact' => \&report;
  #warn %$file;
  $file->process;
  print 'ok\n';
}

sub report {
  my($eaten,$txt) = (shift,shift);
  print "Comment: `", $eaten->[1], "'\n" if defined $eaten->[1];
  #print " " x $txt->{deep}, ref $eaten, ": `", $eaten->[0], "'\n";
  print "@{$txt->{waitfors}} ", ref $eaten, ": `", $eaten->[0], "'";
  if (defined $eaten->[3]) {
    my @arr = @{ $eaten->[3] };
    foreach (@arr) {
      print " ", $_->print;
    }
    #map sub {print " @{ $_[0] }"}, @arr;
  }
  print "\n";
}

readfile;
