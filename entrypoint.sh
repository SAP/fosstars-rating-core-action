#!/bin/bash

REPORT_BRANCH=$1
REPORT_FILE=$2
BADGE_FILE=$3
TOKEN=$4

if [ "$REPORT_BRANCH" = "" ]; then
    echo "Oops! No branch provided!"
    exit 1
fi

if [ "$REPORT_FILE" = "" ]; then
    REPORT_FILE="fosstars_report.md"
fi

if [ "$BADGE_FILE" = "" ]; then
    BADGE_FILE="fosstars_badge.svg"
fi

PROJECT_SCM_URL=$GITHUB_SERVER_URL/$GITHUB_REPOSITORY
RAW_RATING_FILE="fosstars_rating.json"

# Switch to the branch where the report should be stored
git fetch origin $REPORT_BRANCH || git branch $REPORT_BRANCH
git checkout $REPORT_BRANCH
if [ $? -ne 0 ]; then
    echo "Could not switch to branch '$REPORT_BRANCH'"
    echo "Did you fortet to run 'actions/checkout' step in your workflow?"
    exit 1
fi

# Generate a report
java -jar /opt/stuff/fosstars-rating-core/target/fosstars-github-rating-calc.jar \
          --url $PROJECT_SCM_URL \
          --token $TOKEN \
          --verbose \
          --report-file $REPORT_FILE \
          --report-type markdown \
          --raw-rating-file $RAW_RATING_FILE

git add $REPORT_FILE $RAW_RATING_FILE

# Update the current badge
label=$(cat $RAW_RATING_FILE | jq -r .label[1] | tr '[:upper:]' '[:lower:]' | sed 's/ //g')
case $label in
    good|moderate|bad|unclear)
      suffix=$label
      ;;
    *)
      suffix="unknown"
      ;;
esac
wget -O $BADGE_FILE https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-$suffix.svg
git add $BADGE_FILE

# Commit the report and the badge
git config --global user.name "Fosstars"
git config --global user.email "fosstars@users.noreply.github.com"

git commit -m "Update Fosstars report" $REPORT_FILE $BADGE_FILE $RAW_RATING_FILE
if [ $1 -ne 0 ]; then
    echo "Could not commit anything"
    exit 0
fi

git remote set-url origin https://x-access-token:$TOKEN@github.com/$GITHUB_REPOSITORY
git push origin $REPORT_BRANCH
