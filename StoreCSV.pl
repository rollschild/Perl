use strict;
use warnings;

use Data::Dumper;

$| = 1;

sub main {
    my $input = 'test.csv';
    unless(open(INPUT, $input)) {
        die("\nUnable to open file $input!!!\n");
    }

    <INPUT>;
    $/ = "\r\n";
    my @data = ();

    while(my $line = <INPUT>) {
        chomp($line);
        my ($name, $payment, $date) = split(',', $line);
        my %values = (
            "Name" => $name,
            "Payment" => $payment,
            "Date" => $date,
        );
        push(@data, \%values);
    }

    close(INPUT);

    # there're references in the array
    foreach my $line(@data) {
        print(Dumper($line));
        print($line->{"Payment"}."\n");
    }

    # no arrow right here
    print($data[3]{"Name"}."\n");
}

main();
