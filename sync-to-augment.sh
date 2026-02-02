#!/bin/bash

# Sync script to copy agent skills and rules to Augment directories
# - Skills go to ~/.augment/skills/ (user-level, available in all workspaces)
# - Rules go to ~/.augment/rules/ (general coding guidelines)
# Usage: ./sync-to-augment.sh

set -e

AUGMENT_SKILLS_DIR="$HOME/.augment/skills"
AUGMENT_RULES_DIR="$HOME/.augment/rules"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Syncing agent skills and rules to Augment..."

# Create the skills directory if it doesn't exist
if [ ! -d "$AUGMENT_SKILLS_DIR" ]; then
    echo "📁 Creating $AUGMENT_SKILLS_DIR"
    mkdir -p "$AUGMENT_SKILLS_DIR"
fi

# Create the rules directory if it doesn't exist
if [ ! -d "$AUGMENT_RULES_DIR" ]; then
    echo "📁 Creating $AUGMENT_RULES_DIR"
    mkdir -p "$AUGMENT_RULES_DIR"
fi

# Sync skills from skills/ to ~/.augment/skills/
if [ -d "$REPO_DIR/skills" ]; then
    echo "📋 Syncing skills from $REPO_DIR/skills to $AUGMENT_SKILLS_DIR"
    rsync -av --delete "$REPO_DIR/skills/" "$AUGMENT_SKILLS_DIR/"
fi

# Sync rules from rules/ to ~/.augment/rules/
if [ -d "$REPO_DIR/rules" ]; then
    echo "📋 Syncing rules from $REPO_DIR/rules to $AUGMENT_RULES_DIR"
    rsync -av --delete "$REPO_DIR/rules/" "$AUGMENT_RULES_DIR/"
fi

echo "✅ Sync complete!"
echo "   Skills: $AUGMENT_SKILLS_DIR"
echo "   Rules: $AUGMENT_RULES_DIR"

