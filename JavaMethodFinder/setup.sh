#!/bin/bash

echo "Process started ..."
git clone $1




chmod +x gitLogMiner.sh gitDiff.sh existingMethodFinder.sh
cp genOutput.py gitLogMiner.sh gitDiff.sh existingMethodFinder.sh $2
cd $2
mkdir result

./existingMethodFinder.sh
./gitLogMiner.sh

python3 genOutput.py
sort -uo result/finalOutput.csv result/finalOutput.csv

echo "Done !"
