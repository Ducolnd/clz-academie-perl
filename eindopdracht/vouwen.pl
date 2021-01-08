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

$iterations = 15;

for ((1..$iterations)) {
    $new = $order;

    $order = $order . $l . reverse(replace($new));
}


my @coords = ([450,700]);
$angle = 0;
$segment_length = 5;
$angle_step = 91;

foreach $char (split //, $order) {
    $lastx = $coords[-1][0];
    $lasty = $coords[-1][1];

    if ($char eq $l) {
        $angle = ($angle + $angle_step) % 360;
    } else {
        $angle = ($angle - $angle_step) % 360;
    }

    $newx = $lastx + (sprintf("%.10f", cos(deg2rad($angle))) * $segment_length); # Sprintf rond de float's af naar 10 decimalen. Dit gaf eerst problemen omdat PI niet exact was.
    $newy = $lasty + (sprintf("%.10f", sin(deg2rad($angle))) * $segment_length);

    # print "Angle: $angle X: $newx Y: $newy \n";

    push @coords, [$newx, $newy];
}

$coord_string = "M 445,700 L ";

for(my $m = 0; $m <= $#coords; $m++) {    
   for(my $n = 0; $n <= 1 ; $n++) {   
       $coord_string = $coord_string . sprintf("%.0f", $coords[$m][$n]) . ",";
    }   

    chop($coord_string);
    $coord_string = $coord_string . " ";
}  



$svg = "<?xml version='1.0' encoding='UTF-8' standalone='no'?><svg height='2000' width='2000' style='background-color:green;'><g><path style='fill:none;stroke:#000000;stroke-width:2px' d='";

$svg2 = "'/></g></svg>";

$svg_full = $svg . $coord_string . $svg2;

open(file, ">", "dragoncurve.svg");
print file $svg_full;
close(file);
