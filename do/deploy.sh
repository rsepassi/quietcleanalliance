#!/bin/sh
set -e

./build.sh

rm -f built.zip
zip -r built.zip built

curl -H "Content-Type: application/zip" \
     -H "Authorization: Bearer $AUTH" \
     --data-binary "@built.zip" \
     https://api.netlify.com/api/v1/sites/quietcleanalliance.netlify.app/deploys

rm -f built.zip
