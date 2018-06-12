use strict;
use warnings;

$| = 1;

sub main {
    my $input = 'test.csv';
    unless(open(INPUT, $input)) {
        die("\nCannot open $input!!!\n");
    }

    # to skip the header line
    <INPUT>;

    while(my $line = <INPUT>) {
        my @values = split(',', $line);
        # print($_);
        print($values[1] . "\n");
    }

    close INPUT;
}

main();
