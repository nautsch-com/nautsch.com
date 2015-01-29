#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

set -e

if [ -z $GIT_TOKEN ]
    then
        echo "missing option \"GIT_TOKEN\", aborting"
        exit 1
fi

cd public


if [ -d ".git" ]; then
  rm -rf .git
fi

git init

git config user.email "pleasemailus@wercker.com"
git config user.name "wercker"

git add -A

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.

git push -q -f https://$GIT_TOKEN@github.com/nautsch-com/nautsch-com.github.io.git master:master

echo "... finished."