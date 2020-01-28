set -e -u

cd "$1"
echo "Enable special remote at $1"
git annex initremote datalad type=external externaltype=datalad encryption=none
autoenable=true || git annex enableremote datalad
git annex enableremote datalad autoenable=true
