#!/bin/bash
# Watches the project directory and auto-commits + pushes on any file change.
# Requires: git, fswatch (brew install fswatch)

DIR="$(cd "$(dirname "$0")" && pwd)"
BRANCH="main"

echo "👀 Watching $DIR for changes... (Ctrl+C to stop)"

fswatch -o --exclude=".git" "$DIR" | while read -r count; do
  cd "$DIR"

  # Skip if nothing staged-able
  if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    continue
  fi

  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  git add .
  git commit -m "Auto-save: $TIMESTAMP"
  git push origin "$BRANCH"
  echo "✓ Pushed at $TIMESTAMP"
done
