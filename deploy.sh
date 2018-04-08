#!/usr/bin/env bash

# Custom deployment script for Slashiez, to run on Travis CI.
# Pushes src directory to 'local git' running behind an Azure Function App.
#
# @author Tim Malone <tdmalone@gmail.com>

set -euo pipefail

echo
echo Deploying Slashiez!
echo

git clone "${AZURE_GIT_REMOTE}" .deployment
echo

# Exit trap function for cleanup (in case we're not running in CI).
function finish {
  rm -rf .deployment
}
trap finish EXIT

# Reset the git index and remove everything (like rm -rf'ing everything except .git).
# @see https://stackoverflow.com/a/22347541/1982136
echo Removing current files...
(
  cd .deployment
  git rm -rf . > /dev/null
  git clean --force -xd
)

# Copy our /src in, commit and push.
echo Copying new files...
cp -R src/* .deployment/
echo Committing and pushing deployment...
echo
(
  cd .deployment
  git add .
  git commit -m "Deployment from ${TRAVIS_BRANCH:-"unknown branch"} (${TRAVIS_COMMIT_RANGE:-"unknown commit range"})" || echo && echo There is nothing to deploy.
  git push
)
