---
type: auto
description: Creating pull requests with Linear ticket integration and conventional commits
---

# Create Pull Request Skill

This skill helps create pull requests using the GitHub CLI with proper Linear ticket integration and conventional commit formatting.

## When to Use

Use this skill when:
- Creating a new pull request
- The user mentions "create PR", "open PR", "make a pull request"
- Working on a Linear ticket and ready to submit changes

## Requirements

1. **Branch Naming**: Branch name MUST be the Linear ticket number (e.g., `ENG-123`)
   - This automatically links the PR to the Linear ticket
   - Extract ticket number from current branch or ask user if not on a ticket branch

2. **PR Title Format**: Use conventional commits format
   - Format: `<type>(<scope>): <description>`
   - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`
   - Example: `feat(auth): add OAuth2 login support`
   - Example: `fix(api): resolve race condition in user service`

3. **Use GitHub CLI**: ALWAYS use `gh pr create` command, never the GitHub API directly

## Workflow

1. **Check current branch**:
   ```bash
   git branch --show-current
   ```

2. **Verify branch is a ticket number** (e.g., ENG-123, PROJ-456):
   - If not on a ticket branch, ask user for the Linear ticket number
   - Create and checkout new branch if needed: `git checkout -b TICKET-NUMBER`

3. **Ensure changes are committed and pushed**:
   ```bash
   git push -u origin BRANCH-NAME
   ```

4. **Create PR with conventional commit title**:
   ```bash
   gh pr create --title "TYPE(SCOPE): DESCRIPTION" --body "DETAILED_DESCRIPTION"
   ```

## Examples

### Example 1: Feature PR
```bash
# Current branch: ENG-456
gh pr create \
  --title "feat(payments): integrate Stripe payment processing" \
  --body "Implements Stripe integration for payment processing including webhook handlers and error handling."
```

### Example 2: Bug Fix PR
```bash
# Current branch: BUG-789
gh pr create \
  --title "fix(auth): prevent token expiration race condition" \
  --body "Fixes issue where concurrent requests could cause token refresh conflicts."
```

### Example 3: With base branch
```bash
# Creating PR against develop branch
gh pr create \
  --base develop \
  --title "refactor(database): migrate to connection pooling" \
  --body "Refactors database connections to use pooling for better performance."
```

## Best Practices

- **Always verify** the current branch name matches a Linear ticket
- **Ask the user** for the PR title type and description if not clear from context
- **Include meaningful body** that explains what changed and why
- **Set base branch** if not targeting main/master (use `--base` flag)
- **Add reviewers** if requested (use `--reviewer` flag)
- **Add labels** if requested (use `--label` flag)

## Common Conventional Commit Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring without changing functionality
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependency updates
- `ci`: CI/CD configuration changes
- `build`: Build system or external dependency changes

