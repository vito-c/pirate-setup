#!/usr/local/bin/awk -f
function abs(x) {
	y = x < 0 ? -x : x
	return y;
}
BEGIN {
	max = 0;
	min = 0;
	previous = 0;
}
{
	if( $1 == "total" ){ 
		current = $3;
		if( max == 0 ){ # init
			min = current;
			max = current;
			print "total time: " yellow current reset;
			print "summary: best run: " min " worst run: " max ;
		} else if( current > max ) { # bad case - always red
			print "total time: " red current reset " increase of " red (current - max) reset " NEW WORST";
			print "summary: best run: " cyan min reset " worst run: " red max reset " delta prev: " red (current - previous) reset;
			max = current;
		} else { # good case
			if ( current < min ) { # new best - always green
				print "total time: " green current reset " decrease of " green (min - current) reset " NEW BEST";
				print "summary: best run: " green min reset " worst run: " cyan max reset " delta prev: " cyan (previous - current) reset;
				min = current;
			} else if( current < previous ) { # good but not best - alway cyan
				print "total time: " cyan current reset " decrease of " cyan (max - current) reset;
				print "summary: best run: " cyan min reset " worst run: " cyan max reset " delta prev: " cyan (previous - current) reset;
			} else { # trending worse - always yellow
				print "total time: " yellow current reset " decrease of " yellow (max - current) reset;
				print "summary: best run: " yellow min reset " worst run: " yellow max reset " delta prev: " yellow (current - previous) reset;
			}
		}
		print ""
	} else {
		print $0
	}

	previous = current;
}

