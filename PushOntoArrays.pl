use strict;
use warnings;

use Data::Dumper;

$| = 1;

sub main {
    my $input = 'test.csv';

    unless(open(INPUT, $input)) {
        die("\nCannot open $input!!!\n");
    }

    my @lines = (); # this array is not fixed in length
    # my $count = 0;

    <INPUT>;
    $/ = "\r\n";
    while(my $line = <INPUT>) {
        my $retval = chomp($line);
        my @values = split(',', $line);
        # $lines[$count] = $line;
        # ++$count;
        # we can use the push() subroutine
        push(@lines, $line);
    }

    close(INPUT);

    foreach my $line(@lines) {
        print($line."\n");
    }
}

main();
