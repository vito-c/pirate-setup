#!/usr/local/bin/bash
# TODO: Add say functionality
tellajoke(){
	wget --quiet "http://www.ahajokes.com/kkn$@.html";
	stream=$(sed -e '/Knock Knock<br>/,/.*<br><br>/!d' kkn001.html | sed '/^$/d' | sed '/.*who.*/d' | sed '/Knock Knock<br>/d' | sed '/.*there?<br>/d' | sed 's/<br>//g')
	set -f; IFS=$'\n' 
	lines=($(sed -e '/Knock Knock<br>/,/.*<br><br>/!d' kkn001.html | sed '/^$/d' | sed '/.*who.*/d' | sed '/Knock Knock<br>/d' | sed '/.*there?<br>/d' | sed 's/<br>//g')); 
	unset IFS; set +f

	confirm="foo"
	while [[ $confirm != "who's there" && $confirm != "Who's there" && $confirm != "who's there?"  ]]; do
		echo "Knock Knock"
		read confirm
	done

	unset confirm
	con="false"
	while [[ $con != "true" ]]; do
		echo "${lines[0]}" # Random Even Number
		read confirm
		if [[ $confirm =~ "who" ]]; then 
			con="true"
		fi
	done

	unset con
	echo "${lines[1]}"
	con="true"
	while [[ $con == "true" ]]; do 	
		echo "Another joke? (y/n)"
		read confirm
		if [[ $confirm == "y" || $confirm =~ "yes" ]]; then
			con="false"
			goon="true"
		elif [[ $confirm == "n" || $confirm =~ "no" ]]; then
			con="false"
			goon="false"
		fi
	done

	if [[ $goon == "true" ]]; then
		tellajoke
	fi
}

getjokes(){

	rm ./clues.txt
	rm ./answers.txt
	touch ./clues.txt
	touch ./answers.txt

	scount=100
	#for num in 00{1..9}; do
	#for num in {100..182}; do
	for num in {00{1..9},0{10..99}}; do
		#for num in {088}; do num=088
		echo "---- on file kkn$num.html ----"
		if [ ! -f kkn$num.html ]; then
			echo 'get file'
			wget --quiet "http://www.ahajokes.com/kkn$num.html";
		fi
		stream=$(sed -e '/Knock Knock.*<br>/,/.*<br><br>/!d' kkn$num.html | sed '/^$/d' | sed "/Who's there?/d" | sed -E '/Knock Knock.?<br>/d' | sed 's/<br>//g')
		set -f; IFS=$'\n' 
		lines=($(sed -e '/Knock Knock.*<br>/,/.*<br><br>/!d' kkn$num.html | sed '/^$/d' | sed "/Who's there?/d" | sed -E '/Knock Knock.?<br>/d' | sed 's/<br>//g')); 
		unset IFS; set +f

		count=0
		for i in "${lines[@]}"; do 
			if (( $count % 3 == 0 )); then
				echo "$i" # Random Even Number
				echo "$i" >> ./clues.txt
			elif (( ($count + 1) % 3 == 0 )); then
				echo "$i"
				echo "$i" >> ./answers.txt
			fi
			count=$((count+1))
		done

		#scount=$((scount+1))
		#echo $scount

		#if (( $scount < 170 )); then  continue; fi
		#echo "keep going?"
		#read confirm
		#if [[ $confirm =~ "no" || $confirm == "n" ]]; then
		#	break
		#fi
	done
	for num in {100..182}; do
		echo "---- on file kkn$num.html ----"
		if [ ! -f kkn$num.html ]; then
			echo 'get file'
			wget --quiet "http://www.ahajokes.com/kkn$num.html";
		fi
		stream=$(sed -e '/Knock Knock.*<br>/,/.*<br><br>/!d' kkn$num.html | sed '/^$/d' | sed "/Who's there?/d" | sed -E '/Knock Knock.?<br>/d' | sed 's/<br>//g')
		set -f; IFS=$'\n' 
		lines=($(sed -e '/Knock Knock.*<br>/,/.*<br><br>/!d' kkn$num.html | sed '/^$/d' | sed "/Who's there?/d" | sed -E '/Knock Knock.?<br>/d' | sed 's/<br>//g')); 
		unset IFS; set +f

		count=0
		for i in "${lines[@]}"; do 
			if (( $count % 3 == 0 )); then
				echo "$i" # Random Even Number
				echo "$i" >> ./clues.txt
			elif (( ($count + 1) % 3 == 0 )); then
				echo "$i"
				echo "$i" >> ./answers.txt
			fi
			count=$((count+1))
		done
	done
}
