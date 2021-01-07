use warnings;
use List::Util qw/shuffle/;

my @names = ("Duco", "Max", "x", "b", "d", "ew", "we", "234", 'sdfsg');
my $n = @names - 1; # Lengthe van array

sub loot {
    my @shuffled_names = shuffle(@names);
    my $number_self = 0;

    for my $i ((0..$n)){
        if ($names[$i] eq $shuffled_names[$i]) { # Jezelf getrokken
            @shuffled_names[$i, ($i + 1) % $n] = @shuffled_names[($i + 1) % $n, $i]; # Swap met volgende in de lijst en % zodat i niet hoger dan lengte lijst
            ++$number_self;
        }
    }

    return $number_self;
}

my $counter = 0;
my $n_keer = 1000000;
for (1..$n_keer) { # 1000 000 keer
    $counter += loot();
}

print(($counter / ($n_keer * $n)) * 100, "% van de keren heeft iemand zijn eigen lootje getrokken.");

# N %
# 2 100
# 3 41,6
# 4 29,2
# 5 21,9
# 6 17,75
# 7 14,97
# 8 12,92
# 9 11,41
# 10 10,22

# Het verschil in kans werd ook groter bij een kleinere groep vandaar minder decimalen bij lage N
# Het verband wat er te zien is is P = 1/n. Dit wordt eigenlijk alleen duidelijk bij n > 5, wat hiervoor de reden is zou ik niet weten.


# Prettyprint wie wie getrokken heeft
# for my $i ((0..$n)){
# 	print($names[$i], " heeft het lootje van ", $shuffled_names[$i], " getrokken.\n");
# }