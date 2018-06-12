use strict;
use warnings;

$| = 1;

sub main {
    my $file = './MyManJeeves.txt';
    open(INPUT, $file) or die("Input file $file not found!!!\n");

    while(my $line = <INPUT>) {
        if($line =~ /(I..a.)(...)/) {
            print("First match: $1; second match: $2\n");
        }

        if($line =~ /(so*n)/) {
            print("$1\n");
        }
    }

    close(INPUT);
}

main();
