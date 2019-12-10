#datalad create -c hcp_dataset -c inm7 $1/HCP/
datalad create -c hcp_dataset $1/HCP/
cd $1/HCP/

# install the code for building the hcp_dataset
datalad install -d . -s git@github.com:TobiasKadelka/build_hcp.git code/build_hcp


# activate the git annex remote and add the urls. After that, drop the content
mkdir -p ./code/tmp/
while read p; do
   echo "original_url,subject,filename,version" > ./code/tmp/$p.csv
   cat ./code/build_hcp/hcp_table.csv | grep $p | sed -e 's#,HCP_1200/[0-9]\+/\([^/]\+\)#,\1/#' -e 's,.xdlm//,.xdlm/,' -e 's,release-notes//,release-notes/,' >> ./code/tmp/$p.csv
 #  datalad addurls -c hcp_dataset -c inm7 code/tmp/$p.csv '{original_url}?versionId={version}' '{subject}//{filename}'
   datalad addurls -c hcp_dataset code/tmp/$p.csv '{original_url}?versionId={version}' '{subject}//{filename}'
   datalad drop $p
done < ./code/build_hcp/subject_list.txt

# subjectlist, complete_table
