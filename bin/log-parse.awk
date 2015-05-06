#!/usr/local/bin/awk -f
/VC:/{

	if( $2 == "crittercism_init" ){
		"/usr/local/bin/git rev-parse HEAD" | getline sha;
		start=$3;
		print "current git sha " sha;
	}

	print $0

	if( $2 == "init_complete" ){
		end=$3;
		total=end - start;
		printf( "total time: %s\n", total);
	}

	fflush();
}
