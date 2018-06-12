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

# $/ = "</entry>";

sub main {
    my %opts;

    getopts('d:r', \%opts);

    if(!checkusage(\%opts)){
        usage();
        exit();
    }

    my $input_dir = $opts{"d"};
    my @files = get_files($input_dir);
    
    process_files(\@files, $input_dir);

}

sub process_files {
    my ($files, $input_dir) = @_;
    print($input_dir."/ "."\n");
    print(Dumper($files));

    foreach my $file(@$files) {
        process_file($file, $input_dir);
    }
}

sub process_file {
    my ($file, $input_dir) = @_;
    print("Processing $file in $input_dir/ ...\n");
    my $filepath = "$input_dir/$file";
    open(INPUTFILE, $filepath) or die("Unable to open $filepath.\n");
    my $count = 0;
    $/ = "</entry>";
    while(my $chunk = <INPUTFILE>){
        print("\n$count: $chunk");
        my ($band) = $chunk =~ m'<band>(.*?)</band>';
        unless(defined($band)) {
            next;
        }
        my @albums = $chunk =~ m'<album>(.*?)</album>'sg;
        print("Found ".scalar(@albums)." for $band ...\n");
        print(Dumper(@albums));
        ++$count;
    }

    close(INPUTFILE);
}

sub get_files {
    my $input_dir = shift(@_);
    unless(opendir(INPUTDIR, $input_dir)) {
        die("\nUnable to open directory $input_dir.\n");
    }
    print("Input directory is: $input_dir/ .\n");

    my @files = readdir(INPUTDIR);

    closedir(INPUTDIR);
    # to get files only ending with .pl
    @files = grep(/\.xml$/i, @files);
    return @files;
}

sub checkusage() {
    my $opts_ref = shift(@_);
    my $r = $opts_ref->{"r"};
    my $d = $opts_ref->{"d"};
   
    # d is mandatroy
    # r is optional

    unless(defined($d)) {
        return 0;
    }

    return 1;    
}

sub usage {
    print(<<USAGE); # identifier, with no space preceding
usage: perl main.pl <options>
    -d <directory>  specify directory in which to find XML files.
    -r              run the program; process the files.

example usage:
    # Process files in current directory.
    perl main.pl -d . -r

USAGE
}

main();
