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

for i in $(seq 1 1024)
do
    git checkout -B "$PULL_SHARK_BRANCH"
    git commit --allow-empty -m "Pull Shark"
    git push -u origin "$PULL_SHARK_BRANCH"
    gh pr create -f
    gh pr merge --merge --delete-branch
    sleep 3
done
