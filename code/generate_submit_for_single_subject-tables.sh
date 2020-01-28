#!/bin/bash
# v1.0

# print the .submit header
cat << EOT
executable     = /data/project/rehab_hcp/code/update_subject.sh
initialdir     = /data/project/rehab_hcp
universe       = vanilla
request_cpus   = 1
getenv         = true
# condor only seems to know disk space of scratch
#request_disk   = 100G

EOT

# print the jobs
while read p; do
    # associates all jobs with an accounting group
    # that we can use to rate limit these jobs
    # from the outside
    echo "accounting_group = grp_limited"
    echo "arguments = code/corrected_tables/${p}_table.csv $p _redownload"
    echo "log       = condor_logs/${p}_\$(Cluster).log"
    echo "output    = condor_logs/${p}_\$(Cluster).out"
    echo "error     = condor_logs/${p}_\$(Cluster).err"
    echo "queue";
    echo ""

done < code/list.txt
