use strict;
use warnings;

use Data::Dumper;

$| = 1;

sub main {
    my $input = 'test.csv';

    unless(open(INPUT, $input)) {
        die("\nCannot open $input!!!\n");
    }

    <INPUT>;
    $/ = "\r\n";
    while(my $line = <INPUT>) {
        my $retval = chomp($line);
        # chomp $line;
        print($retval."\n");
        my @values = split(',', $line);
        print(join('|', @values)."\n");
        print(Dumper(@values));
    }

    close(INPUT);
}

main();
