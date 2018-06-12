use strict;
use warnings;

use File::Copy;

$| = 1;

sub main {
    if(copy('./output.txt', './SysAdmin/copy.txt')) {
        print("One filed copied!!!\n");
    }
    else {
        print("Unable to copy file!!!\n");
    }
=pod
    move('./output.txt.orig', './SysAdmin') or 
        die("Unable to move file!!!\n");
=cut
    unlink('./SysAdmin/copy.txt') or 
        die("Unable to delete files!!!\n");
}

main();

