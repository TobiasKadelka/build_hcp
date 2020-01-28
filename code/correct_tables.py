import sys
import subprocess
import csv
import os

def main():

	# s3-bucket prefix
	urlPrefix = "s3://hcp-openaccess/HCP_1200/"

	# names of the columns for the table
	header = [["original_url","subject","filename", "version"]]

	input_path  = "./tables/"
	output_path = "./really_corrected/"

	# for every subject-ID in the input-table, it runs the datalad ls
	# and gets the information for the table from that. Just a lot
	# of string-cutting and then wrting the information into the table.
	for file in os.listdir( input_path ):
		row_list = []
		new_table = csv.writer(open(output_path + file, 'w'), delimiter=',', quoting=csv.QUOTE_ALL, quotechar='"' )
		with open(input_path + file) as input_file:
			old_table = csv.reader(input_file, delimiter=';')
			for row in old_table:
				row_0 = row[0].replace(row[1], row[2])
				row_1 = row[1]
				row_2 = row[2].replace( "HCP_1200/" + row[1] + "/", "")
				row_3 = row[3]
				if row_2[0:len(".xdlm/")] != ".xdlm/" and row_2[0:len("release-notes/")] != "release-notes/":
					row_2 = row_2.replace("/", "//", 1)
				row_list.append( [row_0, row_1, row_2, row_3] )
		new_table.writerows( row_list )
	print("All tables are corrected.")
main()
