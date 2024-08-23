#! /bin/bash

if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
else
    exit 1
fi

cd ..

if [ -d "$REPOSITORY_NAME" ]; then
    rm -rf "$REPOSITORY_NAME"
fi

if gh repo view "$REPOSITORY_NAME" &> /dev/null; then
    gh repo delete "$REPOSITORY_NAME" --yes
fi
