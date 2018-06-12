use strict;
use warnings;

use LWP::Simple;

sub main() {
    print "Downloading...\n";
    # print get("https://www.google.com");
    # getstore("https://www.google.com/", "home.html");
    
    # if we do "use strict", we are forced to use the "my" below
    # ... to show it's the first occurrance of this variable
    my $pic = getstore('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu8rQzBovOiIdnFQtbmjMFQVfM9asdfopbDLCVS8IMeOYlfNZuGFfyRQ', "person.png");
    if($pic == 200) {
        print "Success downloading pic.\n";
    }
    else {
        print "Failed downloading!\n";
    }
    
    print "Finished!!!\n";
}

main();
