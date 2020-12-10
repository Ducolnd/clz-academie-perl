sub fibb {
    $n = $_[0];

    if ($n < 2) {
        return $n;
    }

    else {
        return fibb(3) + fibb(1);
    }
}

$a = 2;

print "Fifth fibbonacci number is ", fibb($a), "\n";