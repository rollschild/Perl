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
        push(@lines, \@values);
    }

    close(INPUT);
    print($lines[0][0]."\n");
    foreach my $line(@lines) {
        # here $line is a reference
        # to dereference:
        print("Name: ".$line->[0]."\n");
        print(Dumper($line));
    }
    
     # print(Dumper(@lines));
}

main();
