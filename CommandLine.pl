use strict;
use warnings;

use Data::Dumper;
use Getopt::Std; # argument retrievement

$| = 1;

sub main {
    my %opts;
    # getopt and getopts are DIFFERENT
    getopts('af:c', \%opts); # pass the reference to the hash into this func
    # the colon means it will take arguments
    print(Dumper(%opts));

    my $file = $opts{'f'};
    print("File: $file\n");
}

main();
