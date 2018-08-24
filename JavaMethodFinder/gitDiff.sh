#!/bin/bash


IFS=$'\n'       # make newlines the only separator
set -f   


minusPlusFilter=$(git diff -U0 $1 $2  | grep -oP  "((\+|\-){1,3}.*)|(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{")


for item in $minusPlusFilter
do 
	#echo $item
	
	if [ ! -z $(echo $item | grep -P "((\+|\-){3}.*)") ]; then

		fileName=$(echo $item | grep -P "((\+|\-){3}.*)" | grep -oP "\w+(?:\.\w+)*$")
	
	else
		
		if [ ! -z $(echo $item | grep -P "((\-).*)+(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{") ]; then
			
			minusFullName=$(echo $item | grep -P "((\-).*)+(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{")		
			minusName=$(echo $minusFullName | grep -oP "([a-zA-Z0-9_]+) *\\(" | tr "(" " ")
			#echo $minusName
		
		else

			
			if [ ! -z $(echo $item | grep -P "((\+).*)+(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{") ]; then
				
				plusFullName=$(echo $item | grep -P "((\+).*)+(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{")
				plusName=$(echo $plusFullName | grep -oP "([a-zA-Z0-9_]+) *\\("| tr "(" " " )
				#echo $plusName
			fi
		fi
	fi

	# Compare if two line +/- are equal and then if + line has a longer length that - one, then we report it in our csv output file

	plusFullNameLen=${#plusFullName}
	minusFullNameLen=${#minusFullName}

	# echo $plusFullNameLen
	# echo $minusFullNameLen

	if [ "$plusName" = "$minusName" ] && [ $plusFullNameLen -gt $minusFullNameLen ]; then
		$(echo "$2; $fileName; $minusName; $minusFullName; $plusFullName " >> result/gitDiff.csv)
	fi
done
