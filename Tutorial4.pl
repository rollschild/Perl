use strict;
use warnings;

$| = 1;

# To check if a file exists
sub main() {
    # my $file = './person.png';
    
    # array
    my @files = (
        './person.png', 
        './home.html', 
        './FirstPerl.pl',
        './Tutorial5.pl',
    );

    foreach my $file(@files) {
        if(-f $file) {
          print "Found file: $file.\n";
        }
        else {
          print "File $file not found!!!\n";
        }
    }
}

main();
