# Agent Rules

This repository contains Augment Agent rules and configurations for the newmoon-org organization.

## Purpose

This repository serves as a centralized location for:
- Custom agent rules and instructions
- Shared configurations for Augment Agent
- Best practices and guidelines for AI-assisted development

## Usage

This repository syncs to `~/.augment/rules` where Augment Agent can access the rules.

### Manual Sync

To manually sync the rules to your local Augment directory:

```bash
./sync-to-augment.sh
```

### Automatic Sync

A git post-commit hook is set up to automatically sync rules to `~/.augment/rules` after each commit.

### Initial Setup

After cloning this repository, run the sync script once to populate your Augment rules directory:

```bash
./sync-to-augment.sh
```

## Contributing

Feel free to add new rules or improve existing ones by submitting a pull request.

## License

MIT

