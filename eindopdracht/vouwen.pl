use Math::Trig;
use List::Util qw( min max );

$l = "L";

$order = $l;
$new = "";

%replacements = ("R" => "L", "L" => "R");

$PI = 3.14159265358979;

sub replace { # Vervang R door L en L door R
    my ($s) = @_;
    ($out = $s) =~ s/(@{[join "|", keys %replacements]})/$replacements{$1}/g;

    return $out;
}

sub degress2radians {
    my ($degrees) = @_;
    return ($degrees / 180) * pi;
}

sub createdragon {
    my ($n, $a, $sw) = (@_);

    print "Creating a dragoncurve with $n iterations, $a degree angles and $sw line width. \n";

    $iterations = $n;

    # Construct LRLRLRLLR shi
    for ((0..$iterations)) {
        $new = $order;

        $order = $order . $l . reverse(replace($new));
    }

    # Middle
    $startx = 450;
    $starty = 700;

    my @coords = ([$startx,$starty]);
    $angle = 0;
    $segment_length = 5;
    $angle_step = $a;

    # Construct coords from LLRLRLRL baap
    foreach $char (split //, $order) {
        $lastx = $coords[-1][0];
        $lasty = $coords[-1][1];

        if ($char eq $l) {
            $angle = ($angle + $angle_step) % 360;
        } else {
            $angle = ($angle - $angle_step) % 360;
        }

        $newx = $lastx + (sprintf("%.10f", cos(degress2radians($angle))) * $segment_length); # Sprintf rond de float's af naar 10 decimalen. Dit gaf eerst problemen omdat PI niet exact was.
        $newy = $lasty + (sprintf("%.10f", sin(degress2radians($angle))) * $segment_length);

        # print "Angle: $angle X: $newx Y: $newy \n";

        push @coords, [$newx, $newy];
    }

    # Geen idee
    my @xes = map{ $_->[0]} @coords;
    my @yes = map{ $_->[1]} @coords;

    my $xmin = min @xes;
    my $xmax = sprintf("%.0f", (max @xes) - $xmin);

    my $ymin = min @yes;
    my $ymax = sprintf("%.0f", (max @yes) - $ymin);


    @xes = map{ $_ - $xmin} @xes;
    @yes = map {$_ - $ymin} @yes;

    $sstartx = sprintf("%.0f", $startx - $segment_length - $xmin);
    $sstarty = sprintf("%.0f", $starty - $ymin);

    # Prepare to write to file
    $coord_string = "M " . "$sstartx" . ", " . "$sstarty" . " L ";

    for(my $m = 0; $m <= $#coords; $m++) {  
        $coord_string = $coord_string . sprintf("%.0f", $xes[$m]) . "," . sprintf("%.0f", $yes[$m]) . " ";
    }  

    # Write SVG to file
    $svg = "<?xml version='1.0' encoding='UTF-8' standalone='no'?><svg height='$ymax' width='$xmax'><g><path style='fill:none;stroke:#000000;stroke-width:2px' d='";
    $svg2 = "'/></g></svg>";
    $svg_full = $svg . $coord_string . $svg2;

    unless(-e $a or mkdir $a) {
        die "Unable to create folder $a\n";
    }

    open(file, ">", "$a/iteration_$n.svg");
    print file $svg_full;
    close(file);
}

# Iterations, angle, line-width
createdragon(17, 91, 2);
