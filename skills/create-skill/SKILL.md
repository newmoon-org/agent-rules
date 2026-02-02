---
name: create-skill
description: Guide for creating new agent skills following the agentskills.io specification. Use when creating, designing, or structuring new skills for AI agents.
---

# Creating Agent Skills

This skill provides comprehensive guidance on creating new agent skills that follow the [agentskills.io](https://agentskills.io) specification.

## When to Use This Skill

- Creating a new skill from scratch
- Understanding the agentskills.io format
- Validating skill structure and frontmatter
- Organizing skill content and resources

## Skill Structure Overview

A skill is a directory containing at minimum a `SKILL.md` file:

```
skill-name/
└── SKILL.md          # Required
```

Optional directories:
```
skill-name/
├── SKILL.md          # Required
├── scripts/          # Executable code
├── references/       # Additional documentation
└── assets/           # Static resources (templates, images, data)
```

## Step-by-Step Workflow

### 1. Choose a Skill Name

The skill name must:
- Be 1-64 characters
- Use only lowercase letters, numbers, and hyphens (a-z, 0-9, -)
- Not start or end with a hyphen
- Not contain consecutive hyphens (--)
- Match the directory name

**Good examples:** `pdf-processing`, `data-analysis`, `code-review`
**Bad examples:** `PDF-Processing`, `-pdf`, `pdf--processing`

### 2. Create the Directory

```bash
mkdir -p skills/skill-name
```

### 3. Create SKILL.md with Required Frontmatter

Every `SKILL.md` must start with YAML frontmatter containing two required fields:

```yaml
---
name: skill-name
description: A clear description of what this skill does and when to use it.
---
```

### 4. Write a Strong Description

The description field (1-1024 characters) should:
- Describe what the skill does
- Explain when to use it
- Include specific keywords for agent discovery

**Good example:**
```yaml
description: Extracts text and tables from PDF files, fills PDF forms, and merges multiple PDFs. Use when working with PDF documents or when the user mentions PDFs, forms, or document extraction.
```

**Poor example:**
```yaml
description: Helps with PDFs.
```

### 5. Add Optional Frontmatter Fields

#### license (optional)
```yaml
license: Apache-2.0
```
or
```yaml
license: Proprietary. LICENSE.txt has complete terms
```

#### compatibility (optional, 1-500 characters)
Only include if your skill has specific environment requirements:
```yaml
compatibility: Requires git, docker, jq, and access to the internet
```

#### metadata (optional)
For additional custom properties:
```yaml
metadata:
  author: your-org
  version: "1.0"
  category: development
```

#### allowed-tools (optional, experimental)
Space-delimited list of pre-approved tools:
```yaml
allowed-tools: Bash(git:*) Bash(jq:*) Read
```

### 6. Write the Skill Body

After the frontmatter, write clear instructions in Markdown. Recommended sections:

- **Overview**: What the skill does
- **When to Use**: Specific scenarios
- **Workflow**: Step-by-step instructions
- **Examples**: Input/output examples
- **Best Practices**: Tips and recommendations
- **Common Pitfalls**: What to avoid
- **Error Handling**: How to handle failures

Keep the main `SKILL.md` under 500 lines. Move detailed content to reference files.

### 7. Add Supporting Files (Optional)

#### scripts/
Executable code that agents can run:
- Python, Bash, JavaScript, etc.
- Self-contained or clearly documented dependencies
- Helpful error messages
- Graceful edge case handling

#### references/
Additional documentation loaded on demand:
- `REFERENCE.md` - Detailed technical reference
- `FORMS.md` - Form templates or structured data
- Domain-specific files (`finance.md`, `legal.md`)

Keep reference files focused and small for efficient context usage.

#### assets/
Static resources:
- Document templates
- Configuration templates
- Diagrams and images
- Lookup tables and schemas

### 8. Use Relative File References

Reference files from `SKILL.md` using relative paths:

```markdown
See [the reference guide](references/REFERENCE.md) for details.

Run the extraction script:
scripts/extract.py
```

Keep references one level deep. Avoid nested chains.

## Progressive Disclosure

Structure skills for efficient context usage:

1. **Metadata** (~100 tokens): `name` and `description` loaded at startup for all skills
2. **Instructions** (<5000 tokens): Full `SKILL.md` body loaded when skill is activated
3. **Resources** (as needed): Files in `scripts/`, `references/`, `assets/` loaded only when required

## Validation

Validate your skill using the skills-ref library:

```bash
skills-ref validate ./skills/skill-name
```

This checks:
- Valid frontmatter format
- Required fields present
- Naming conventions followed
- Field constraints met

## Skills vs Rules

**Use Skills when:**
- Specialized domain knowledge is needed
- Metadata-based discovery is important
- Content should be loaded on-demand
- Following agentskills.io standard

**Use Rules when:**
- General coding guidelines apply
- Content-based or always-applied rules
- Augment-specific functionality

## Complete Example

```yaml
---
name: github-pr-linear
description: Create GitHub pull requests with Linear ticket integration and conventional commit formatting using gh CLI
---

# GitHub PR with Linear Integration

This skill helps create GitHub pull requests that integrate with Linear tickets
and follow conventional commit standards.

## When to Use

- Creating a PR from a Linear ticket branch
- Need conventional commit formatting
- Want auto-merge enabled

## Workflow

1. Ensure you're on the correct branch (e.g., `linear-ticket-123`)
2. Verify all changes are committed
3. Use `gh pr create` with conventional commit title
4. Link to Linear ticket in description
5. Optionally enable auto-merge

[... rest of skill content ...]
```

## Best Practices

1. **Clear naming**: Use descriptive, kebab-case names
2. **Specific descriptions**: Include keywords and use cases
3. **Concise main file**: Keep `SKILL.md` under 500 lines
4. **Progressive disclosure**: Move details to reference files
5. **Examples**: Include concrete input/output examples
6. **Validation**: Always validate before committing
7. **Version control**: Track skills in git
8. **Documentation**: Explain when and how to use the skill

## Common Pitfalls

- ❌ Uppercase or spaces in skill names
- ❌ Vague descriptions without keywords
- ❌ Missing required frontmatter fields
- ❌ Overly long `SKILL.md` files
- ❌ Deeply nested file references
- ❌ Undocumented script dependencies
- ❌ No examples or use cases

## Next Steps

After creating your skill:

1. Validate with `skills-ref validate`
2. Test with your agent
3. Sync to `~/.augment/skills/` (if using Augment)
4. Commit to version control
5. Share with your team or community

