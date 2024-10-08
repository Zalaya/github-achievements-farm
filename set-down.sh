#! /bin/bash

if [ -f ".env" ]
then
    echo "Setting up environment variables..."
    export $(grep -v '^#' .env | xargs)
    echo "Environment variables set up successfully!"
else
    echo "Environment variables not found!"
    exit 1
fi

cd ..

if [ -d "$REPOSITORY_NAME" ]
then
    echo "Removing existing directory..."
    rm -rf "$REPOSITORY_NAME"
else
    echo "Directory not found!"
fi

if gh repo view "$REPOSITORY_NAME" &> /dev/null
then
    echo "Deleting existing repository..."
    gh repo delete "$REPOSITORY_NAME" --yes
else
    echo "Repository not found!"
fi

echo "Everything has been set down successfully!"
