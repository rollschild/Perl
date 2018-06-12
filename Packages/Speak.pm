package Packages::Speak;

use Exporter qw(import);
# for now, one package in one module

@EXPORT_OK = qw(test whatup);
# @EXPORT = qw(test); # not best practice
# can be used with 
# use Speak
sub test {
    print("Hello from package Speak.\n");
}

sub whatup {
    print("Hey what up man!!!\n");
}

# return 1;
1;
