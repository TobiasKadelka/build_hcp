"original_url,subject,filename,version" > unraw.csv
while read p; do
  subID=$p | cut -d ' ' -f2
  cat hcp_table.csv | grep ',$subID,' | sed -e 's#,HCP_1200/[0-9]\+/\([^/]\+\)#,\1/#' -e 's,.xdlm//,.xdlm/,' -e 's,release-notes//,release-notes/,' >>| unraw.csv
done <hcp1200_sub_list.txt
