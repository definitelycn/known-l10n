#!/bin/bash

for file in $(git diff --cached --name-only | grep -E '\.(po)$')
do
  git show ":$file" | /usr/bin/msgfmt "$file"
 # we only want to lint the staged changes, not any un-staged changes
  if [ $? -ne 0 ]; then
    echo "msgfmt failed on staged file '$file'. Please check your strings and try again."
    exit 1 # exit with failure status
  fi
done

