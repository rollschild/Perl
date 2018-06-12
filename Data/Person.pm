package Data::Person;
use Data::Dumper;
sub new {
    print(Dumper(@_));
    my $class = shift;

    # an object is a special form of hash
    # reference to a hash
    my $self = {
        "name" => shift,
        "age" => shift,
    };

    bless($self, $class);
    return $self;
}

sub greet {
    print(Dumper(@_));
    my ($self, $other) = @_;

    print("Hello $other!!! My name is ".$self->{"name"}.".\n");
    print("And I am ".$self->{"age"}." years old!!!\n");
}

1;
