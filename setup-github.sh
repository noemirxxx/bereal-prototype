#!/bin/bash
# Run once to initialise the repo and push to GitHub
set -e

REPO_NAME="bereal-prototype"
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "→ Initialising git repo..."
cd "$DIR"
git init
git add .
git commit -m "Initial commit: BeReal profile prototype"

echo "→ Creating GitHub repo and pushing..."
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

echo ""
echo "✓ Done! Repo live at: https://github.com/$(gh api user --jq .login)/$REPO_NAME"
echo ""
echo "Run ./watch-and-push.sh to start auto-pushing on save."
