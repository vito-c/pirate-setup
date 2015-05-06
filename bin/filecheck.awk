#!/usr/bin/awk -f
{
	if ($1 == "??") untracked[ length(untracked) + 1 ] = $2; 
	if ($1 == "A") added[ length(added) + 1 ] = $2;
	if ($1 == "D") deleted[ length(deleted) + 1 ] = $2;
	#if ($1 == "M") modified[ length(modified) + 1 ] = $2;
	if ($1 == "U") unmerged[ length(unmerged) + 1 ] = $2;
} END {
	output = 0;
	if ( length(untracked) > 0 ) {
		output = 1;
		print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  untracked files  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
		for ( i=1; i<=length(untracked); i++ ) print untracked[i];
	}
	if ( length(added) > 0 ) {
		output = 1;
		print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  added files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
		for ( i=1; i<=length(added); i++ ) print added[i];
	}
	if ( length(deleted) > 0 ) {
		output = 1;
		print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  deleted files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
		for ( i=1; i<=length(deleted); i++ ) print deleted[i];
	}
	#if ( length(modified) > 0 ) {
	#	output = 1;
	#	print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  modified files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
	#	for ( i=1; i<=length(modified); i++ ) print modified[i];
	#}
	if ( length(unmerged) > 0 ) {
		output = 1;
		print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  unmerged files <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
		for ( i=1; i<=length(unmerged); i++ ) print unmerged[i];
	}
	if ( output == 1 ) {
		print "====================================================================================";
		print "===================== YOU HAVE FAILED THE SANITY CHECK =============================";
		print "======= You forgot to do one of the following:         =============================";
		print "======= 1. commit meta files for assets                =============================";
		print "======= 2. delete meta files for your assets           =============================";
		print "====================================================================================";
		exit 1;
	}
}
