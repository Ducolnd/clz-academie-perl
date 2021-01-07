$steps = 0;

sub col {
    my ($n) = @_;

    if ($n == 1) {
        return " is een wonderlijk getal"
    }

    $steps = $steps + 1;

    if ($n % 2 == 0) { # Even getal
        return col($n / 2);
    } else {
        return col(($n * 3) + 1)
    }
}

for my $i ((1..1000)){
	print($i, col($i), " \n");
}
