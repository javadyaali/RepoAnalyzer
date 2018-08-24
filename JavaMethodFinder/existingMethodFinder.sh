#!/bin/bash

# using 'find' command to select .java extension files
javaFilePath=`find | grep -P "\.java"`
filePathList=$(echo $javaFilePath | tr " " "\n")

# Iterate over paths and find methods and list them in a text file
for path in $filePathList
do
	methodNames=$(cat $path | grep -P "(public|private|static|protected|abstract|native|synchronized) +([a-zA-Z0-9<>._?, ]+) +([a-zA-Z0-9_]+) *\\([a-zA-Z0-9<>\\[\\]._?, \n]*\\) *([a-zA-Z0-9_ ,\n]*) *\\{" | grep -oP "([a-zA-Z0-9_]+) *\\(" | tr "(" "\n")
	$(echo $methodNames | tr " " "\n" >> result/methodNames.txt)
done

sort -u -o result/methodNames.txt result/methodNames.txt