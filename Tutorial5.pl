use strict;
use warnings;

$| = 1;

sub main {
    my $file = './MyManJeeves.txt';
    open(INPUT, $file) or die("Input file $file not found!!!\n");
    while(my $line = <INPUT>) {
        # <INPUT> reads one line of a file and returns
        # print("$line");
        if($line =~ / egg /) {
            print("$line");
        }
    }
    close(INPUT); # it's a subroutine
}

main();
