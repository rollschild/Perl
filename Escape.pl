use strict;
use warnings;

$| = 1;

sub main {
    # \d digit
    # \s space
    # \S any single non-space char
    # \w alphanumeric, including "_", excluding "."

    my $text = 'I am 1223 years old tomorrow.';

    if($text =~ /(am\s\d+)/) {
        print("$1\n");
    }
}

main();
