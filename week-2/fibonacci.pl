# Heel onefficiente manier om de fibonacci reeks te berekenen
# omdat je elke keer opnieuw het Nde getal moet berekenen.

sub fibb {
    my ($n) = @_;

    if ($n < 2) {
        return $n;
    }

    else {
        return fibb($n - 1) + fibb($n - 2);
    }
}

$a = 20;

print "Fibonacci nummer is ", fibb($a), "\n";