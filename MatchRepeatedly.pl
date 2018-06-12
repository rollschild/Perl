use strict;
use warnings;

use LWP::Simple;

$| = 1;

sub main {
    my $content = get("http://www.google.com");

    unless(defined($content)) {
        die("\nUnreachable content!!!\n");
    }

    while($content =~ 
          m|<\s*a\s+[^>]*href\s*=\s*['"]([^'"]+)['"][^>]*>\s*([^<>]*)\s*</|sig) {
        print("$2: $1\n");
    }
}

main();
