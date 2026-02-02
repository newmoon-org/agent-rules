---
name: create-rule
description: Guide for creating Augment Agent rules that define coding standards, workflows, and best practices. Use when creating rules for general coding guidelines, always-applied standards, or Augment-specific functionality.
---

# Creating Augment Agent Rules

This skill provides comprehensive guidance on creating rules for Augment Agent. Rules are different from skills - they define general coding guidelines and standards that are always applied or content-based.

## When to Use This Skill

- Creating coding standards and guidelines
- Defining workflow requirements (like PR workflows)
- Establishing best practices for the codebase
- Setting up always-applied rules for Augment Agent
- Creating Augment-specific functionality rules

## Rules vs Skills

### Use Rules When:
- ✅ General coding guidelines apply to all code
- ✅ Content-based or always-applied standards
- ✅ Augment-specific functionality
- ✅ Workflow enforcement (e.g., PR requirements)
- ✅ Code style and formatting standards
- ✅ Security or compliance requirements

### Use Skills When:
- ✅ Specialized domain knowledge is needed
- ✅ Metadata-based discovery is important
- ✅ Content should be loaded on-demand
- ✅ Following agentskills.io standard
- ✅ Task-specific instructions

## Rule Structure

A rule is a Markdown file in the `rules/` directory with optional YAML frontmatter:

```
rules/
├── pr-workflow.md
├── code-style.md
└── security-guidelines.md
```

## Step-by-Step Workflow

### 1. Choose a Rule Name

The rule filename should:
- Use kebab-case (lowercase with hyphens)
- Be descriptive and clear
- End with `.md`
- Reflect the rule's purpose

**Good examples:** `pr-workflow.md`, `code-style.md`, `security-guidelines.md`
**Bad examples:** `Rule1.md`, `my_rule.md`, `WORKFLOW.md`

### 2. Determine Rule Type

Rules can have different types in the frontmatter:

#### `type: auto`
Automatically applied to all interactions. Use for critical, always-enforced rules.

```yaml
---
type: auto
---
```

**Use for:**
- Workflow requirements (PR workflows)
- Security standards
- Critical best practices
- Code quality gates

#### No frontmatter (content-based)
Applied based on content relevance. Augment loads these when the content is relevant to the task.

**Use for:**
- Language-specific guidelines
- Framework-specific patterns
- Domain-specific standards
- Optional best practices

### 3. Create the Rule File

Following the PR workflow rule, create a feature branch first:

```bash
git checkout -b add-rule-name
```

Then create the rule file:

```bash
# Create in rules/ directory
touch rules/rule-name.md
```

### 4. Write the Rule Content

#### Structure Your Rule

A well-structured rule should include:

1. **Title** - Clear heading describing the rule
2. **Purpose** - Why this rule exists
3. **Requirements** - What must be done
4. **Guidelines** - How to follow the rule
5. **Examples** - Good and bad examples
6. **Exceptions** - When the rule doesn't apply
7. **Enforcement** - How the rule is enforced

#### Example Rule Template

```markdown
---
type: auto
---

# [Rule Name]

**[Brief statement of the rule's core requirement]**

## Purpose

[Explain why this rule exists and what problem it solves]

## Requirements

[List specific requirements that must be followed]

1. Requirement 1
2. Requirement 2
3. Requirement 3

## Guidelines

[Provide detailed guidance on how to follow the rule]

### Step 1: [Action]
[Details]

### Step 2: [Action]
[Details]

## Examples

### Good Example
```
[Show correct implementation]
```

### Bad Example
```
[Show incorrect implementation]
```

## Exceptions

[List any exceptions to the rule]

- Exception 1
- Exception 2

## Enforcement

[Explain how the rule is enforced]
```

### 5. Use Clear, Actionable Language

**Good:**
- ✅ "NEVER push directly to main"
- ✅ "ALWAYS create a feature branch"
- ✅ "Use conventional commit format"

**Bad:**
- ❌ "Try to avoid pushing to main"
- ❌ "Consider using branches"
- ❌ "Commits should probably follow a format"

### 6. Include Visual Markers

Use emojis and symbols to make rules scannable:

- ✅ Correct/Required
- ❌ Incorrect/Forbidden
- ⚠️ Warning/Caution
- 📋 Note/Information
- 🔒 Security-related
- 🚀 Performance-related

### 7. Provide Context and Rationale

Explain WHY the rule exists, not just WHAT it requires. This helps developers understand and follow the rule.

**Good:**
```markdown
## Why This Rule Exists

Pushing directly to main bypasses code review, CI/CD checks, and can introduce
bugs into production. PRs ensure all changes are reviewed and tested.
```

**Bad:**
```markdown
## Rule

Don't push to main.
```

## Common Rule Types

### Workflow Rules
- PR requirements
- Branch naming conventions
- Commit message formats
- Code review processes

### Code Quality Rules
- Linting standards
- Testing requirements
- Documentation requirements
- Code style guidelines

### Security Rules
- Authentication requirements
- Data handling standards
- Dependency management
- Secret management

### Architecture Rules
- Design patterns
- File organization
- Module structure
- API design standards

## Best Practices

1. **Be Specific**: Vague rules are hard to follow
2. **Be Consistent**: Rules should align with each other
3. **Be Practical**: Rules should be enforceable
4. **Provide Examples**: Show both good and bad examples
5. **Explain Why**: Include rationale for the rule
6. **Keep Updated**: Review and update rules regularly
7. **Make Scannable**: Use headings, lists, and markers
8. **Test the Rule**: Ensure Augment can understand and apply it

## Complete Example

See `rules/pr-workflow.md` in this repository for a complete example of a well-structured rule with:
- Clear frontmatter (`type: auto`)
- Strong enforcement language
- Step-by-step workflow
- Examples of what to do and what not to do
- Branch naming conventions
- Exception handling
- Rationale for the rule

## Validation

After creating a rule:

1. **Test with Augment**: Ask Augment to perform a task that should trigger the rule
2. **Verify Enforcement**: Ensure the rule is being followed
3. **Check Clarity**: Make sure the rule is understandable
4. **Review Examples**: Confirm examples are accurate
5. **Sync to Augment**: Ensure rule is in `~/.augment/rules/`

## Syncing Rules

Rules in the `rules/` directory are automatically synced to `~/.augment/rules/` via:

```bash
./sync-to-augment.sh
```

This happens automatically on commit via the git post-commit hook.

## Next Steps

After creating your rule:

1. Follow the PR workflow (as defined in `rules/pr-workflow.md`)
2. Create a feature branch
3. Add the rule file
4. Commit with conventional commit message
5. Push the feature branch
6. Create a PR with auto-merge
7. Wait for merge
8. Pull main and sync

**Remember: Rules define how we work. Make them clear, actionable, and valuable.**

