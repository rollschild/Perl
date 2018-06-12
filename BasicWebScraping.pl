use strict;
use warnings;

use LWP::Simple;

$| = 1;

sub main {
    my $content = get("http://www.caveofprogramming.com");
    unless(defined($content)) {
        die("\nUnreachable content!!!\n");
    }

    if($content =~ m'<a class="highlight-link" href=".+?">(.+?)</a>'i) { # case insensitive
        my $title = $1;
        print("Title: $title\n");
    }
    else {
        print("\nTitle not found!!!\n");
    }

}

main();
