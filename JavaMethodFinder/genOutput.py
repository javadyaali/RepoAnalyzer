import os
import re
import sys
import subprocess
import csv


def main():


	# Load bash output file into the list
	text_file = open("result/methodNames.txt", "r")
	existingMethods = text_file.read().split('\n')

	# Making final csv file
	with open("result/gitDiff.csv", 'r') as csv_file:
			csv_reader = csv.reader(csv_file, delimiter=';')
			for commitInformation in csv_reader:

				# Cleaning lines
				commitSHA = commitInformation[0]
				fileName = commitInformation[1].lstrip()
				methodName = commitInformation[2].split(" ")[0]
				formerSignature = commitInformation[3].split('-')[1].split('{')[0].lstrip().rstrip()
				newSignature = commitInformation[4].split('+')[1].split('{')[0].lstrip().rstrip()


				# Report output
				if (methodName in existingMethods) and (len(newSignature)>=2) and (len(formerSignature) < len(newSignature)):
					with open('result/finalOutput.csv', 'a') as output:
						output.write(commitSHA + ',' + fileName + ',' + formerSignature + ',' + newSignature + '\n')






if __name__ == "__main__":
	main()