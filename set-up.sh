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
    gh repo delete "$REPOSITORY_NAME" --confirm
fi

gh repo create "$REPOSITORY_NAME" --"$REPOSITORY_VISIBILITY" --confirm
gh repo clone "$REPOSITORY_NAME"

cd "$REPOSITORY_NAME"

echo "# $REPOSITORY_NAME" > README.md

git add .
git commit -m "docs(readme): add the readme.md file to the structure of the project, this will contain the project documentation"
git push origin main
