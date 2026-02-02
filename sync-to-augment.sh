#!/bin/bash

# Sync script to copy agent rules to ~/.augment/rules
# Usage: ./sync-to-augment.sh

set -e

AUGMENT_RULES_DIR="$HOME/.augment/rules"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Syncing agent rules to Augment..."

# Create the rules directory if it doesn't exist
if [ ! -d "$AUGMENT_RULES_DIR" ]; then
    echo "📁 Creating $AUGMENT_RULES_DIR"
    mkdir -p "$AUGMENT_RULES_DIR"
fi

# Copy all files from this repo to ~/.augment/rules
# Exclude .git directory and this sync script
echo "📋 Copying files from $REPO_DIR to $AUGMENT_RULES_DIR"
rsync -av --exclude='.git' --exclude='sync-to-augment.sh' --exclude='.gitignore' "$REPO_DIR/" "$AUGMENT_RULES_DIR/"

echo "✅ Sync complete! Agent rules are now in $AUGMENT_RULES_DIR"

