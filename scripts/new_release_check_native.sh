#!/bin/bash
set -eu

# PACKAGE TO CHECK FOR NEW RELEASES
PACKAGE_NAME="aws-cli"

# GET THE PACKAGE INFO
PACKAGE_INFO=$(wget -qO- https://pkgs.alpinelinux.org/package/edge/community/aarch64/aws-cli)
# WE CARE ONLY FOR THE 'Build time'
BUILD_DATE=$(echo "${PACKAGE_INFO}" | grep -A2 'Build time' | sed -n 's/.*<td>\(.*\)<\/td>.*/\1/p')
# GET THE 'Version' AS WE USE IT FOR OUR OWN TAGS
TAG_NAME=$(echo "${PACKAGE_INFO}" | grep -A3 'Version' | sed -n 's/.*>\(.*\)<\/a>.*/\1/p')
# EXTRACT THE DATE OF THE BUILD AND MAKE IT A TIMESTAMP
TIMESTAMP=$(echo "${BUILD_DATE}" | date -f - +%s)
# GET THE CURRENT TIME
CURRENT_TIMESTAMP=$(date +%s)
# AND SUBTRACT 24 HOURS AS WE CHECK 1 TIME PER DAY
TIMESTAMP_24_HOURS_AGO=$((CURRENT_TIMESTAMP - 86400))

# CHECK IF OUR TAG WAS CREATED WITHIN THE LAST 24 HOURS
if [[ $TIMESTAMP -gt $TIMESTAMP_24_HOURS_AGO ]]; then
  echo "Found a native package with name ${TAG_NAME} within the last 24 hours. Tagging this repository to trigger rebuild"
  git tag "${TAG_NAME}"
  git push origin "${TAG_NAME}"
else
  echo "No new releases found, nothing to do"
fi
