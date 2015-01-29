#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

set -e


if [ -z $GIT_TOKEN ]
    then
        echo "missing option \"GIT_TOKEN\", aborting"
        exit 1
fi

exit 0


# Build the project.
# hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd public
# Add changes to git.

if [ -d ".git" ]; then
  rm -rf .git
fi

git init
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.

git push -f https://$GIT_TOKEN@github.com/nautsch-com/nautsch-com.github.io.git master:master

echo "... finished."