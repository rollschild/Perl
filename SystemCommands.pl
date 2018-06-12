use strict;
use warnings;

$| = 1;

sub main {
    my @output = `ls -lt`;
    foreach my $output(@output) {
        print($output);
    }
}

main();
