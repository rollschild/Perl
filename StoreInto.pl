use strict;
use warnings;

use Data::Dumper;
use Getopt::Std;
use XML::Simple;

use DBI;
$XML::Simple::PREFERRED_PARSER = 'XML::Parser';
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
    
    my @data = process_files(\@files, $input_dir);
    add_to_databaes(\@data);
    print(Dumper(@data));
}

sub add_to_databaes {
    my $driver = "Pg";
    my $database = "rollschild";
    my $dsn = "DBI:$driver:dbname = $database";
    my $userid = "rollschild";
    my $password = '@0o0oo00oo@';
    my $data = shift(@_);
    my $dbh = DBI->connect($dsn, $userid, $password, {RaiseError => 1})
        or die(DBI::errstr);
    print("Successfully opened database!!!\n");
    my $sth = $dbh->prepare('INSERT INTO bands (name) VALUES (?)');
    my $sth_albums = $dbh->prepare(
    'INSERT INTO albums (name, position, band_id) values (?, ?, ?)');
    unless($sth) {
        die("Error preparing Postgres!!!\n");
    }
    # prepare with place holders
    $dbh->do('DELETE FROM albums') or die("Error cleaning table!!!\n");
    $dbh->do('DELETE FROM bands') or die("Error cleaning the table!!!\n");
    # !!! we cannot delete bands first, since its data is used 
    # ... by albums
    foreach my $data(@$data) {
        my $band_name = $data->{"name"};
        my $albums = $data->{"albums"};
        print("Inserting...\n");
        unless($sth->execute($band_name)) {
            die("Error executing SQL!!!\n");
        }
        my $band_id = $dbh->last_insert_id(
                      undef, undef, 'bands', 'id');
        foreach my $album(@$albums) {
            my $album_name = $album->{"name"};
            my $album_position = $album->{"position"};
            unless($sth_albums->execute(
                    $album_name, $album_position, $band_id)) {
                die("Error insertion!!!\n");
            }
        }

        # my $seq_num = $dbh->do("SELECT currval('bands_id_seq')");
        # my $seq_num = $dbh->last_insert_id(
        # undef, undef, 'bands', 'id') or die("Error!\n");
        print("$band_id\n");
    }

    $sth->finish();
    $sth_albums->finish();
    unless(defined($dbh->disconnect())) {
        die("Error disconnecting from database!!!\n");
    }
    print("Discnonnected!!!\n");
}

sub process_files {
    my ($files, $input_dir) = @_;
    print($input_dir."/ "."\n");
    print(Dumper($files));
    my @data;

    foreach my $file(@$files) {
        push(@data, process_file($file, $input_dir));
    }

    return @data;
}

sub process_file {
    my ($file, $input_dir) = @_;
    print("Processing $file in $input_dir/ ...\n");
    my $filepath = "$input_dir/$file";
    open(INPUTFILE, $filepath) or die("Unable to open $filepath.\n");
    # $/ = "</entry>";
    undef($/); # NO record separator defined
    my $content = <INPUTFILE>;
    close(INPUTFILE);
    print($content);

    # a blessed hash turned into object
    my $parser = new XML::Simple;

    # dom: document object model
    # a hash reference
    my $dom = $parser->XMLin($content, ForceArray => 1);
    print(Dumper($dom));
    my @output;
    # now we have a reference to an array
    # an array of hashes
    # print(Dumper($dom->{"entry"}));
    foreach my $band(@{$dom->{"entry"}}) {
        my $band_name = $band->{"band"}->[0];
        my $albums = $band->{"album"};
        my @albums;
        foreach my $album(@$albums) {
            my $album_name = $album->{"name"}->[0];
            my $chartposition = $album->{"chartposition"}->[0];
            print("$album_name: $chartposition .\n");

            push(@albums, {
                "name"=> $album_name,
                "position" => $chartposition,
                });
        }

        push(@output, {
            "name" => $band_name,
            "albums" => \@albums,
            });
    }

    print(Dumper(@output));
    return @output;
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
    my $r = $opts_ref->{"d"};
    my $d = $opts_ref->{"r"};
   
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
    -d <directory>  import data; specify directory in which to find XML files.
    -r              export data from database.

example usage:
    # Process files in current directory.
    perl main.pl -d
    perl main.pl -r

USAGE
}

main();
