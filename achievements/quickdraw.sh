#! /bin/bash

if [ -f "../.env" ]
then
    echo "Setting up environment variables..."
    export $(grep -v '^#' ../.env | xargs)
    echo "Environment variables set up successfully!"
else
    echo "Environment variables not found!"
    exit 1
fi

cd ../..

if [ ! -d "$REPOSITORY_NAME" ]
then
    echo "Directory not found!"
    exit 1
fi

cd "$REPOSITORY_NAME"

if [ $(basename "$(pwd)") != "$REPOSITORY_NAME" ]
then
    echo "Repository name does not match!"
    exit 1
fi

git checkout -B "$QUICKDRAW_BRANCH"
git commit --allow-empty -m "Quickdraw"
git push -u origin "$QUICKDRAW_BRANCH"
gh pr create -f
gh pr review --approve
gh pr merge --rebase --delete-branch
