use Math::Trig;

$l = "L";
$r = "R";

$order = $l;
$new = "";

%replacements = ("R" => "L", "L" => "R");

$PI = 3.14159265358979;

sub replace { # Vervang R door L en L door R
    my ($s) = @_;
    ($out = $s) =~ s/(@{[join "|", keys %replacements]})/$replacements{$1}/g;

    return $out;
}

sub deg2rad {
    my ($degrees) = @_;
    return ($degrees / 180) * pi;
}

$iterations = 3;

for ((1..$iterations)) {
    $new = $order;

    $order = $order . $l . reverse(replace($new));
}


my @coords = ([0,0], [10,0]);
$angle = 0;
$segment_length = 10;

foreach $char (split //, $order) {
    $lastx = $coords[-1][0];
    $lasty = $coords[-1][1];

    if ($char eq $l) {
        $angle = ($angle + 90) % 360;
    } else {
        $angle = ($angle - 90) % 360;
    }

    $xmove = sprintf("%.8f", cos(deg2rad($angle))) * $segment_length;
    $ymove = sprintf("%.8f", sin(deg2rad($angle))) * $segment_length;

    $newx = $lastx + (sprintf("%.8f", cos(deg2rad($angle))) * $segment_length);
    $newy = $lasty + (sprintf("%.8f", sin(deg2rad($angle))) * $segment_length);

    print "Angle: $angle X: $newx Y: $newy \n";

    push @coords, [$newx, $newy];
}



$svg = "<?xml version='1.0' encoding='UTF-8' standalone='no'?><svg><g><pathstyle='fill:none;stroke:#000000;stroke-width:2px'd='M 0,0 L10, 010, 1020, 1020, 20'/></g></svg>";
