# cat ./hcp_table.csv | grep ',$subID,' | sed -e 's#,HCP_1200/[0-9]\+/\([^/]\+\)#,\1/#' -e 's,.xdlm//,.xdlm/,' -e 's,release-notes//,release-notes/,'


table_path = "/data/BnB_USER/Kadelka/BIDS_DATALAD/build_hcp/code/create/hcp1200_sub_list.txt"

print("echo original_url,subject,filename,version")
with open( table_path, 'r' ) as table:
	for line in table:
		if not "PRE " in line:
			continue
		subjectID = line.split("PRE ")[-1].replace("/\n", "")
		print ("cat /data/BnB_USER/Kadelka/BIDS_DATALAD/build_hcp/code/create/hcp_table.csv | grep '," + subjectID + ",' | sed -e 's#,HCP_1200/[0-9]\+/\([^/]\+\)#,\\1/#' -e 's,.xdlm//,.xdlm/,' -e 's,release-notes//,release-notes/,' >> unraw.csv")
