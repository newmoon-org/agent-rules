---
name: github-pr-linear
description: Create GitHub pull requests with Linear ticket integration and conventional commit formatting using gh CLI
---

# GitHub PR with Linear Integration

This skill provides guidance for creating pull requests using the GitHub CLI (`gh`) with proper Linear ticket integration and conventional commit formatting.

## When to Use This Skill

Apply this skill when:
- Creating a new pull request
- Working on a Linear ticket and ready to submit changes
- User mentions "create PR", "open PR", "make a pull request", or similar

## Core Requirements

### 1. Branch Naming Convention
- Branch name **MUST** be the Linear ticket number (e.g., `ENG-123`, `PROJ-456`)
- This automatically links the PR to the Linear ticket
- If not on a ticket branch, ask the user for the Linear ticket number

### 2. PR Title Format (Conventional Commits)
Use the conventional commits format:
```
<type>(<scope>): <description>
```

**Valid Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, semicolons, etc.)
- `refactor`: Code refactoring without changing functionality
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependency updates
- `ci`: CI/CD configuration changes
- `build`: Build system or external dependency changes

**Examples:**
- `feat(auth): add OAuth2 login support`
- `fix(api): resolve race condition in user service`
- `refactor(database): migrate to connection pooling`

### 3. Always Use GitHub CLI
- **ALWAYS** use `gh pr create` command
- **NEVER** use the GitHub API directly

## Step-by-Step Workflow

### Step 1: Check Current Branch
```bash
git branch --show-current
```

### Step 2: Verify Branch is a Ticket Number
- Confirm the branch name matches a Linear ticket pattern (e.g., `ENG-123`)
- If not on a ticket branch:
  - Ask user for the Linear ticket number
  - Create and checkout new branch: `git checkout -b TICKET-NUMBER`

### Step 3: Ensure Changes are Committed and Pushed
```bash
git push -u origin BRANCH-NAME
```

### Step 4: Check if Repository Has Auto-Merge Enabled
```bash
gh repo view --json autoMergeAllowed -q .autoMergeAllowed
```

### Step 5: Create PR with Conventional Commit Title
```bash
gh pr create --title "TYPE(SCOPE): DESCRIPTION" --body "DETAILED_DESCRIPTION"
```

### Step 6: Enable Auto-Merge (if repository supports it)
If the repository has auto-merge enabled and the user wants it:
```bash
gh pr merge --auto --squash
```
Or for merge commit:
```bash
gh pr merge --auto --merge
```
Or for rebase:
```bash
gh pr merge --auto --rebase
```

## Command Examples

### Basic Feature PR
```bash
# Current branch: ENG-456
gh pr create \
  --title "feat(payments): integrate Stripe payment processing" \
  --body "Implements Stripe integration for payment processing including webhook handlers and error handling."
```

### Bug Fix PR
```bash
# Current branch: BUG-789
gh pr create \
  --title "fix(auth): prevent token expiration race condition" \
  --body "Fixes issue where concurrent requests could cause token refresh conflicts."
```

### PR Against Specific Base Branch
```bash
# Creating PR against develop branch
gh pr create \
  --base develop \
  --title "refactor(database): migrate to connection pooling" \
  --body "Refactors database connections to use pooling for better performance."
```

### PR with Reviewers and Labels
```bash
gh pr create \
  --title "feat(api): add rate limiting middleware" \
  --body "Adds configurable rate limiting to prevent API abuse." \
  --reviewer username1,username2 \
  --label enhancement,backend
```

### PR with Auto-Merge Enabled
```bash
# Create the PR
gh pr create \
  --title "feat(api): add rate limiting middleware" \
  --body "Adds configurable rate limiting to prevent API abuse."

# Enable auto-merge with squash (most common)
gh pr merge --auto --squash
```

## Best Practices

1. **Always verify** the current branch name matches a Linear ticket
2. **Ask the user** for the PR title type and description if not clear from context
3. **Include meaningful body** that explains what changed and why
4. **Set base branch** if not targeting main/master (use `--base` flag)
5. **Add reviewers** if requested (use `--reviewer` flag)
6. **Add labels** if requested (use `--label` flag)
7. **Keep scope concise** - use one or two words (e.g., `auth`, `api`, `database`)
8. **Description should be imperative** - "add feature" not "adds feature"
9. **Check for auto-merge** - If repository has auto-merge enabled, ask user if they want to enable it
10. **Default to squash merge** - When enabling auto-merge, use `--squash` unless user specifies otherwise

## Common Patterns

### Scope Selection
- Use the primary area of change: `auth`, `api`, `ui`, `database`, `config`
- For multiple areas, use the most significant one
- Omit scope if change is global: `chore: update dependencies`

### Description Guidelines
- Start with lowercase
- No period at the end
- Be concise but descriptive
- Use imperative mood ("add" not "added")

## Auto-Merge

### When to Use Auto-Merge

Enable auto-merge when:
- Repository has auto-merge feature enabled
- PR has required checks configured
- User wants the PR to merge automatically after approvals and checks pass

### Auto-Merge Strategies

1. **Squash** (recommended for most cases):
   ```bash
   gh pr merge --auto --squash
   ```
   - Combines all commits into one
   - Keeps main branch history clean
   - PR title becomes the commit message

2. **Merge Commit**:
   ```bash
   gh pr merge --auto --merge
   ```
   - Preserves all commits from the PR
   - Creates a merge commit
   - Full history is maintained

3. **Rebase**:
   ```bash
   gh pr merge --auto --rebase
   ```
   - Replays commits on top of base branch
   - No merge commit created
   - Linear history

### Checking Auto-Merge Status

To check if a repository has auto-merge enabled:
```bash
gh repo view --json autoMergeAllowed -q .autoMergeAllowed
```

Returns `true` if auto-merge is available, `false` otherwise.

## Error Handling

If `gh pr create` fails:
- Verify user is authenticated: `gh auth status`
- Check if branch is pushed to remote
- Confirm repository has remote configured
- Ensure user has permission to create PRs in the repository

If `gh pr merge --auto` fails:
- Verify repository has auto-merge enabled
- Check if user has permission to enable auto-merge
- Ensure PR has been created successfully
- Confirm required checks are configured (auto-merge won't work without them)

