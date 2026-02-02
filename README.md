# Augment Agent Skills & Rules

This repository contains Augment Agent skills and configurations for the newmoon-org organization.

## Purpose

This repository serves as a centralized location for:
- **Skills**: Specialized domain knowledge following the [agentskills.io](https://agentskills.io) specification
- **Rules**: General coding guidelines and project conventions
- Shared configurations for Augment Agent
- Best practices and workflows for AI-assisted development

## What's Included

### Skills (`.augment/skills/`)
Skills are specialized domain knowledge packages following the agentskills.io specification:

- **`github-pr-linear`**: Create GitHub PRs with Linear ticket integration and conventional commits

Skills are discoverable by Augment and provide focused guidance for specific workflows.

### Rules (`.augment/rules/`)
General coding guidelines and project conventions (if any are added in the future).

## Usage

This repository syncs to `~/.augment/rules` where Augment Agent can access the skills and rules.

### Manual Sync

To manually sync to your local Augment directory:

```bash
./sync-to-augment.sh
```

### Automatic Sync

A git post-commit hook automatically syncs to `~/.augment/rules` after each commit.

### Initial Setup

After cloning this repository, run the sync script once:

```bash
./sync-to-augment.sh
```

## Contributing

Feel free to add new rules or improve existing ones by submitting a pull request.

## License

MIT

