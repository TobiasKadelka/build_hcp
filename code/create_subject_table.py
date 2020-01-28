#!/usr/bin/env python
# needs a subject-ID

import sys
import subprocess
import csv

def main():

	# s3-bucket prefix
	global urlPrefix
	urlPrefix = "s3://hcp-openaccess/HCP_1200/"

	# names of the columns
	header = [["original_url","subject","filename", "version"]]

	# create/open the table and write the header/column names
	global this_table
	subject_ID = sys.argv[1]
	output_path = sys.argv[2]
	table_name = output_path + subject_ID + "_table.csv"
	this_table = csv.writer(open( table_name, 'w'), delimiter=';')
	this_table.writerows( header )

	# get the output of the "datalad ls"-command
	output = subprocess.getoutput("datalad ls -Lr s3://hcp-openaccess/HCP_1200/" + subject_ID + "/")
	list_of_files = output.split("\n")
	# parsing the information
	for file in list_of_files:
		if not "HCP_1200/" in file:
			continue
		parts = file.split(" ")
		file_name = parts[0]
		orig_url = "s3://hcp-openaccess/" + subject_ID
		version = ""
		for part in parts:
			if "ver:" in part:
				version = part[ 4 : ]
			if version == "":
				continue
#		print([[orig_url, subject_ID, file_name, version]])
		this_table.writerows([[orig_url, subject_ID, file_name, version]])

main()
