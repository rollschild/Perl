use strict;
use warnings;

$| = 1;

use Data::Dumper;

sub main {
    my %months = (
        "Jan" => 1,
        "Dec" => 12,
        "Mar" => 3,
        "Oct" => 10,
    );

    my %days = (
        1 => "Monday",
        3 => "Wednesday",
        4 => "Thursday",
    );

    print $months{"Dec"}."\n";

    print $days{3}."\n";

    my @months = keys(%months);
    foreach my $month(@months) {
        my $value = $months{$month};
        print("$month: $value\n");
    }

    while(my ($key, $value) = each(%days)) {
        print("$key: $value\n");
    }
}

main();
