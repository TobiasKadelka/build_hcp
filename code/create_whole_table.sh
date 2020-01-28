#!/usr/bin/env  bash
# needs a subject-ID
set -e -u

bigtable="$1"
subject="$2"
outdir="$3"
outds="$outdir/$subject"
#subj_table="$outds/.git/tmp/${subject}_table.csv"

# this checks, if a folder already exists. But for that, we have the option "--ifexists skip", I hope?
#if [ -e "$outds" ]; then
#    echo "Output dataset $outds already exists. Aborting."
#    exit 1
#fi

datalad create -c hcp_dataset "$outds"
# mkdir -p "$(dirname $subj_table)"

# echo "original_url;subject;filename;version" > "$subj_table"

# first line with , as delimiter did not work cause of small part of files with comma in name.
# zgrep "$subject" "$bigtable" | sed -e 's#;HCP_1200/[0-9]\+/\([^/]\+\)#;\1/#' -e 's;.xdlm//;.xdlm/;' -e 's;release-notes//;release-notes/;' >> "$subj_table"
#cat "$bigtable" | sed -e 's#,HCP_1200/[0-9]\+/\([^/]\+\)#,\1/#' -e 's,.xdlm//,.xdlm/,' -e 's,release-notes//,release-notes/,' > "$subj_table"

datalad --dbg -l warning addurls --ifexists skip -d "$outds" -c hcp_dataset "$bigtable" '{original_url}?versionId={version}' '{filename}'

datalad drop -d "$outds" -r --nocheck

# deal with stale NFS links
# https://github.com/datalad/datalad/issues/3921#issuecomment-565948197
git -C "$outds" submodule foreach --recursive 'chmod -R u+wx .git/annex/objects; rm -rf .git/annex/objects'
chmod -R u+wx "$outds/.git/annex/objects" && rm -rf "$outds/.git/annex/objects"

# maximum cleanup
git -C "$outds" submodule foreach --recursive git gc --aggressive --prune=now
git -C "$outds" gc --aggressive --prune=now
#rm "$subj_table"
