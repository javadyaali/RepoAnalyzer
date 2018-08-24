#!/bin/bash


commits=$(git log | grep -P "^commit +(\b[0-9a-f]{40}\b)" | sed s/commit//g)


# Counter for initializing
iter=1

for item in $commits
do
	echo $item 
	if [ $iter -eq 1 ]; then
		endCommit=$item
		beginCommit=$item
	else
		beginCommit=$item

		./gitDiff.sh $beginCommit $endCommit
		endCommit=$beginCommit
	fi

	let "iter++"
done