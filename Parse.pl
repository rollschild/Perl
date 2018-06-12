use strict;
use warnings;

use Data::Dumper;
use Getopt::Std;

$| = 1;

# multiline comment or documentation:
# pod = plain old documentation
=pod
    This is ACME XML parser version 1.0
    Use with care.
=cut

sub main {
    my %opts;

    getopts('af:r', \%opts);

    if(!checkusage(\%opts)){
        usage();
    }
=pod 
    my $opts_ref = \%opts;
    print("Use hash directly.\n");
    print($opts{"f"}."\n");
    print("Use reference.\n");
    print($opts_ref->{"f"}."\n");
=cut
}

sub checkusage() {
=pod 
    my %opts = @_;
    print(Dumper(%opts));
    print($opts{'f'}."\n");
    my $greeting = shift(@_);
    my $index = shift(@_);
    my ($greeting, $index) = @_;
    print($greeting.": ".$index."\n");
=cut
    my $opts_ref = shift(@_);
    my $a = $opts_ref->{"a"};
    my $r = $opts_ref->{"r"};
    my $f = $opts_ref->{"f"};
    print("From checkusage: ".$opts_ref->{"f"}."\n");
    
    unless(defined($r) and defined($f)) {
        print("Use -r to run the program.\n");
        return 0;
    }

    unless($f =~ /\.xml$/i) {
        print("File must have the extension .xml.\n");
        return 0;
    }

    return 1;    
}

sub usage {
    # print("Wrong options!!!\n");
    # define a multi-line string:
    my $str = <<USAGE; # identifier, with no space preceding
usage: perl main.pl <options>
    -f <file name>  specify XML file name to parse
    -a              turn off error checking
    -r              run the program

example usage:
    perl main.pl -f test.xml -r

USAGE
    die($str);
    # or we can use 
    # print(<<USAGE);
    # then:
    # exit();
}

main();
