use strict;
use warnings;

use Data::Dumper;

use lib '.';
use Packages::Speak qw(test whatup);

$| = 1;

sub main {
    # Speak::test();
    test();
    whatup();
    my @dogs = qw(retriever labrador alsatian);
    print(Dumper(@dogs));
}

main();
