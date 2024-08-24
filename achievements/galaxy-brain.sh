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

if [ $(basename "$(pwd)" != $REPOSITORY_NAME) ]
then
    echo "Repository name does not match!"
    exit 1
fi

for i in $(seq 1 32)
do
    git checkout -B "$GALAXY_BRAIN_BRANCH"
    git commit --allow-empty -m "Galaxy Brain"
    git push -u origin "$GALAXY_BRAIN_BRANCH"
    gh pr create -f
    gh pr review --approve
    gh pr merge --squash --delete-branch
    sleep 3
done
