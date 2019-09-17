# First argument: Path to install the DTA_study data
# Second argument: which sourcedata to use

# create a dataset
datalad create $1
cd $1

datalad install -d . -s git@github.com:TobiasKadelka/build_hcp.git code/build_hcp

datalad addurls code/build_hcp/code/create/hcp_table.csv '{original_url}' '{subject}/{filename}'
