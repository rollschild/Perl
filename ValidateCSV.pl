use strict;
use warnings;

use Data::Dumper;

$| = 1;

sub main {
    $/ = "\r\n";
    my $input = 'test.csv';
    unless(open(INPUT, $input)) {
        die("\nUnable to open file $input!!!\n");
    }

    <INPUT>;
    my @data;

    POINT: while(my $line = <INPUT>) {
        # check if the line is blank
        $line =~ /\S+/ or next;
        
        chomp $line;
        my @values = split(',', $line);

        foreach my $value(@values) {
            if($value eq '') {
                print("Invalid line: $line\n");
                next POINT;
            }
        }

        if(scalar(@values) < 3) {
            print("Invalid line: $line\n");
            next;
        }

        my($name, $payment, $date) = @values;
        my %values = (
            "Name" => $name,
            "Payment" => $payment,
            "Date" => $date,
        );

        push(@data, \%values);
    }

    close(INPUT);

    foreach my $line(@data) {
        print($line->{"Payment"} . "\n");
    }
}

main();
