use strict;
use warnings;

use Data::Dumper;

$| = 1;

sub main {
    my %hash_one = (
        "cats" => "fish",
        "birds" => "seeds",
        "fish" => "worms",
    );

    my @array_of_hash;
    push(@array_of_hash, \%hash_one);
    print($array_of_hash[0]{"birds"}."\n");
}

main();
