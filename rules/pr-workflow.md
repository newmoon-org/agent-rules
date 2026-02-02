---
type: auto
---

# Pull Request Workflow Rule

**CRITICAL: NEVER push directly to the `main` branch. ALL code changes MUST go through a Pull Request.**

## Required Workflow

1. **Create a feature branch** from main
   - Use descriptive branch names (e.g., `flow-123-feature-name` for Linear tickets)
   - Use kebab-case for branch names
   
2. **Make your changes** on the feature branch
   - Commit changes with conventional commit messages
   - Test your changes locally
   
3. **Push the feature branch** to origin
   ```bash
   git push -u origin branch-name
   ```
   
4. **Create a Pull Request** using the `github-pr-linear` skill
   - Use conventional commit format for PR title
   - Include Linear ticket reference if applicable
   - Add detailed description of changes
   - Enable auto-merge if repository supports it
   
5. **Wait for PR to merge** (auto-merge) or manually merge after approval
   
6. **Switch back to main and pull**
   ```bash
   git checkout main
   git pull
   ```
   
7. **Delete the feature branch** (optional cleanup)
   ```bash
   git branch -d branch-name
   ```

## What NOT to Do

❌ **NEVER** commit directly to main
❌ **NEVER** push directly to main
❌ **NEVER** use `git push` when on the main branch with new commits

## Exceptions

The ONLY acceptable direct pushes to main are:
- Initial repository setup (first commit)
- Emergency hotfixes (with explicit user permission)
- Repository configuration changes (with explicit user permission)

## If You Accidentally Push to Main

If you realize you've pushed to main:
1. Inform the user immediately
2. Ask if they want to revert the commit
3. Create a proper PR workflow for future changes

## Branch Naming Conventions

- **Linear tickets**: `flow-123-short-description` or `linear-ticket-id-description`
- **Features**: `feature/description`
- **Bug fixes**: `fix/description`
- **Refactoring**: `refactor/description`

Use the Linear ticket ID when available for automatic PR linking.

## Conventional Commit Format for PRs

PR titles should follow conventional commits:
- `feat(scope): description` - New features
- `fix(scope): description` - Bug fixes
- `docs(scope): description` - Documentation changes
- `refactor(scope): description` - Code refactoring
- `test(scope): description` - Test changes
- `chore(scope): description` - Maintenance tasks

## Auto-Merge Strategy

When creating PRs, prefer enabling auto-merge with squash strategy:
```bash
gh pr create --title "feat(skill): add new skill" --body "Description" --fill
gh pr merge --auto --squash
```

This ensures:
- Clean commit history on main
- Automatic merging after checks pass
- PR title becomes the commit message

## Enforcement

Before ANY push operation:
1. Check current branch: `git branch --show-current`
2. If on `main`, STOP and create a feature branch instead
3. Only push feature branches
4. Create PR to merge into main

**Remember: Protecting main branch integrity is critical for team collaboration and code quality.**

