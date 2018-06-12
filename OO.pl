use strict;
use warnings;

use lib '.';
use Data::Person;

$| = 1;

sub main {
    my $person_1 = new Data::Person("Jovi", 45);
    $person_1->greet("Eva");

    my $person_2 = new Data::Person("Lily", 25);
    $person_2->greet("Jovi");
}

main();
