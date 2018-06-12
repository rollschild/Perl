use strict;
use warnings;

use LWP::Simple;

$| = 1;

# NOTICE:
# Efficiency issues: you store everthing in memory all at once

sub main {
    my $content = get("https://duckduckgo.com");
    unless(defined($content)) {
        die("\nUnreachable content!!!\n");
    }

    my @classes = $content =~ m|class="([^"']*?)"|ig;

    unless(scalar(@classes) > 0) {
        die("\nNo classes retrieved!!!\n");
    }

    foreach my $class(@classes) {
        print("$class\n");
    }
}

main();
