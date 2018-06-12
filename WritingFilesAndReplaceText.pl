use strict;
use warnings;

$| = 1;

sub main {
    my $input = './MyManJeeves.txt';
    open(INPUT, $input) or die("Input file $input not found!!!\n");

    # my $output = '>output.txt';
    my $output = 'output.txt';
    open(OUTPUT, '>'.$output) or die("Cannot create $output.\n");
    
    while(my $line = <INPUT>) {
        # replace you with YOU
        # g means globally
        # i means the search is case insensitive, but we don not want it here
        # it does NOT change the input file
        # $line =~ s/you/YOU/g;
        if($line =~ /\begg\b/) {
            # \b is a word boundary
            $line =~ s/you/YOU/ig;
            $line =~ s/\bhen\b/dinosaur/ig;
            print OUTPUT ($line);
        }
    }
    close(INPUT);
    close(OUTPUT);
}

main();
