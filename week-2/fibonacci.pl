# Heel onefficiente manier om de fibonacci reeks te berekenen
# omdat je elke keer opnieuw het Nde getal moet berekenen.

@reeks = (0,1); # Eerste 2 getallen 

sub fibb {
    my ($n) = @_;

    if ($n < 2) {
        return $reeks[$n];
    } 

    else {
        push @reeks, (fibb($n - 1) + fibb($n - 2));

        return @reeks[-1];
    }
}

$a = 4;

print "Fibonacci nummer is ", fibb(10), "\n";