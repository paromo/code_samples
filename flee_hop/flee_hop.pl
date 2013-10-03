use Time::HiRes qw(usleep);

@data = (
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
);

sub print_2d {
	my @array_2d=@_;
	for(my $i = 0; $i <= $#array_2d; $i++){
	   for(my $j = 0; $j <= $#{$array_2d[0]} ; $j++){
	      print "$array_2d[$i][$j] ";
	   }
	   print "\n";
	}
}


sub get_value {
	my $range = 3;
	my $minimum = -1;
	my $rnd = int(rand($range)) + $minimum;
	return $rnd;
}

sub get_valid_move {
	$x = $_[0];
	$y = $_[1];
	while (1){
		$x_move = get_value();
		$y_move = get_value();
		if ($x == 0 && $y == 0 && $x_move != -1 && $y_move != -1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x > 0 && $x < 14 && $y == 0 && $y_move != -1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x == 14 && $y == 0 && $x_move != 1 && $y_move != -1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x == 0 && $y > 0 && $y < 14 && $x_move != -1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x > 0 && $x < 14 && $y > 0 && $y < 14 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x == 14 && $y > 0 && $y < 14 && $x_move != 1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x == 0 && $y == 14 && $x_move != -1 && $y_move != 1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x > 0 && $x < 14 && $y == 14 && $y_move != 1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
		if ($x == 14 && $y == 14 && $x_move != 1 && $y_move != 1 && !($x_move == 0 && $y_move == 0)) {
			return($x_move,$y_move);
		}
	}
}

sub handle_bugs {
	$x = $_[0];
	$y = $_[1];
	$bugs = $_[2];
	my $move_x, my $move_y;
	for ($i = 0; $i < $bugs; $i++){
		($move_x, $move_y) = get_valid_move($x,$y);
		$data[$x+$move_x][$y+$move_y]++;
		$data[$x][$y]--;
	}
}

sub get_biggest {
	my @array_2d=@_;
	my $biggest = 0;
	for(my $i = 0; $i <= $#array_2d; $i++){
	   for(my $j = 0; $j <= $#{$array_2d[0]} ; $j++){
	      if ($array_2d[$i][$j] > $biggest) {
		$biggest = $array_2d[$i][$j];
	      }
	   }
	}
	return $biggest;
}

my $runs = 0;
my @start_state_data = undef;
print "\n\n";
print "INITIAL STATE:\n";
print_2d(@data);
sleep 4;
print "\n\n";

while($runs < 101) {
	$runs++;
	@start_state_data = map { [@$_] } @data;
	for ($x_t = 0; $x_t < 15; $x_t++){
		for ($y_t = 0; $y_t < 15; $y_t++){
			if ($start_state_data[$x_t][$y_t] != 0) {
				handle_bugs($x_t,$y_t,$start_state_data[$x_t][$y_t]);
			}
# Uncomment these lines if you wish to check how each cell is evaluated.
#		print "RUN: $runs\n\n";
#		print_2d(@start_state_data);
#		print "\n\n";
#		print_2d(@data);
#		print "\n\n";
# You can either follow by pressing enter of using timeout
#		<STDIN>;
#      OR
#		usleep(100000);
		}
	}
	if ($runs == 25 || $runs == 50 || $runs == 100) {
		my $most_bugs = get_biggest(@data);
		print "CHECKPOINT (RUN: $runs / HIGHEST CONCENTRATION OF BUGS: $most_bugs):\n";
		print_2d(@data);
		print "\n\n";
		sleep 4;
	}
}


