---
type: auto
---

# Pre-Push Quality Checks Rule

**CRITICAL: Before pushing code to a feature branch or creating a PR, ALWAYS run quality checks to ensure code meets standards.**

## Purpose

This rule ensures that all code pushed to GitHub meets quality standards by running linters, formatters, tests, and builds before pushing. This prevents broken code from entering the CI/CD pipeline and wasting time on failed builds.

This rule applies to both **JavaScript/TypeScript** projects (npm/Node.js) and **Kotlin/Java** projects (Gradle).

## Required Checks Before Push

Before running `git push`, you MUST complete ALL of the following checks based on your project type:

### 1. Code Formatting

#### JavaScript/TypeScript Projects (Prettier)

Run Prettier to ensure consistent code formatting:

```bash
# Check formatting
npm run format:check
# or
npx prettier --check .

# Fix formatting issues
npm run format
# or
npx prettier --write .
```

#### Kotlin/Java Projects (ktlint)

Run ktlint to ensure consistent Kotlin code formatting:

```bash
# Check formatting
./gradlew ktlintCheck

# Fix formatting issues
./gradlew ktlintFormat
```

✅ **Required:** All files must pass formatting checks
❌ **Never push** code with formatting errors

### 2. Linting

#### JavaScript/TypeScript Projects (ESLint)

Run ESLint to catch code quality issues and potential bugs:

```bash
# Check for linting errors
npm run lint
# or
npx eslint .

# Fix auto-fixable issues
npm run lint:fix
# or
npx eslint . --fix
```

#### Kotlin/Java Projects (detekt)

Run detekt for static code analysis:

```bash
# Run detekt
./gradlew detekt
```

✅ **Required:** All files must pass linting checks with no errors
⚠️ **Warnings:** Address warnings when possible, but errors are blocking

### 3. Type Checking (TypeScript)

If the project uses TypeScript, run type checking:

```bash
# Type check
npm run type-check
# or
npx tsc --noEmit
```

✅ **Required:** No TypeScript errors
❌ **Never push** code with type errors

### 4. Tests

#### JavaScript/TypeScript Projects

Run all tests to ensure functionality is not broken:

```bash
# Run all tests
npm test
# or
npm run test

# Run tests in watch mode during development
npm run test:watch

# Run tests with coverage
npm run test:coverage
```

#### Kotlin/Java Projects

Run all tests using Gradle:

```bash
# Run all tests
./gradlew test

# Run tests with coverage
./gradlew test jacocoTestReport
```

✅ **Required:** All tests must pass
❌ **Never push** code with failing tests
📋 **Note:** Add tests for new functionality

### 5. Build

#### JavaScript/TypeScript Projects

Ensure the project builds successfully:

```bash
# Build the project
npm run build

# For Next.js projects
npm run build

# For other frameworks, use appropriate build command
```

#### Kotlin/Java Projects

Build the project using Gradle:

```bash
# Build the project
./gradlew build

# Build without running tests (if tests already run separately)
./gradlew assemble

# Clean and build
./gradlew clean build
```

✅ **Required:** Build must complete without errors
❌ **Never push** code that doesn't build
⚠️ **Build warnings:** Review and address when possible

## Complete Pre-Push Workflow

### JavaScript/TypeScript Projects

Follow this workflow before every push:

```bash
# 1. Ensure you're on your feature branch
git branch --show-current

# 2. Run formatting
npm run format

# 3. Run linting
npm run lint

# 4. Run type checking (if TypeScript)
npm run type-check

# 5. Run tests
npm test

# 6. Run build
npm run build

# 7. If all checks pass, commit any formatting fixes
git add .
git commit -m "chore: apply formatting and linting fixes"

# 8. Push to feature branch
git push
```

### Kotlin/Java Projects (Gradle)

Follow this workflow before every push:

```bash
# 1. Ensure you're on your feature branch
git branch --show-current

# 2. Run formatting
./gradlew ktlintFormat

# 3. Run linting/static analysis
./gradlew detekt

# 4. Run tests
./gradlew test

# 5. Run build
./gradlew build

# 6. If all checks pass, commit any formatting fixes
git add .
git commit -m "chore: apply formatting and linting fixes"

# 7. Push to feature branch
git push
```

## Automated Pre-Push Script

### JavaScript/TypeScript Projects

Consider creating a pre-push script in `package.json`:

```json
{
  "scripts": {
    "pre-push": "npm run format && npm run lint && npm run type-check && npm test && npm run build",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "build": "next build"
  }
}
```

Then run before pushing:

```bash
npm run pre-push
```

### Kotlin/Java Projects (Gradle)

Create a custom Gradle task in `build.gradle.kts`:

```kotlin
tasks.register("prePush") {
    dependsOn("ktlintFormat", "detekt", "test", "build")
    group = "verification"
    description = "Run all pre-push quality checks"
}
```

Then run before pushing:

```bash
./gradlew prePush
```

## Git Pre-Push Hook (Optional)

### JavaScript/TypeScript Projects

For automatic enforcement, create a git pre-push hook at `.git/hooks/pre-push`:

```bash
#!/bin/sh

echo "🔍 Running pre-push quality checks..."

# Run checks
npm run format:check && npm run lint && npm run type-check && npm test && npm run build

# Capture exit code
RESULT=$?

if [ $RESULT -ne 0 ]; then
  echo "❌ Pre-push checks failed. Please fix the issues before pushing."
  exit 1
fi

echo "✅ All pre-push checks passed!"
exit 0
```

Make it executable:
```bash
chmod +x .git/hooks/pre-push
```

### Kotlin/Java Projects (Gradle)

For automatic enforcement, create a git pre-push hook at `.git/hooks/pre-push`:

```bash
#!/bin/sh

echo "🔍 Running pre-push quality checks..."

# Run checks
./gradlew ktlintCheck detekt test build

# Capture exit code
RESULT=$?

if [ $RESULT -ne 0 ]; then
  echo "❌ Pre-push checks failed. Please fix the issues before pushing."
  exit 1
fi

echo "✅ All pre-push checks passed!"
exit 0
```

Make it executable:
```bash
chmod +x .git/hooks/pre-push
```

## Handling Check Failures

### Formatting Failures

**JavaScript/TypeScript:**
```bash
# Auto-fix formatting
npm run format
git add .
git commit -m "chore: fix formatting"
```

**Kotlin/Java:**
```bash
# Auto-fix formatting
./gradlew ktlintFormat
git add .
git commit -m "chore: fix formatting"
```

### Linting Failures

**JavaScript/TypeScript:**
```bash
# Auto-fix linting issues
npm run lint:fix
git add .
git commit -m "chore: fix linting issues"

# For manual fixes, address each error and commit
```

**Kotlin/Java:**
```bash
# Review detekt report (usually in build/reports/detekt/)
# Fix issues manually and commit
git add .
git commit -m "chore: fix linting issues"
```

### Type Check Failures
- Review TypeScript errors carefully
- Fix type issues (don't use `any` as a quick fix)
- Ensure proper type definitions
- Commit fixes with descriptive message

### Test Failures
- Review failing tests
- Fix the code or update tests as appropriate
- Never skip or comment out failing tests
- Add new tests for bug fixes

### Build Failures
- Review build errors and warnings
- Fix import issues, missing dependencies
- Ensure all required environment variables are documented
- Test the build output

## Exceptions

The ONLY acceptable reasons to skip checks:

1. **Emergency Hotfix** - With explicit approval and plan to fix later
2. **Work in Progress** - Pushing to personal/draft branch (not for PR)
3. **Documentation Only** - Changes only to `.md` files (still run format check)

Even with exceptions, you MUST:
- Document why checks were skipped
- Create a follow-up task to address issues
- Never merge to main without passing checks

## CI/CD Integration

These checks should also run in CI/CD:

- GitHub Actions should run the same checks
- PRs should not be mergeable if checks fail
- Auto-merge should only trigger after all checks pass

## Best Practices

1. **Run checks frequently** during development, not just before push
2. **Fix issues immediately** rather than accumulating them
3. **Keep checks fast** to encourage frequent running
4. **Update dependencies** regularly to avoid check failures
5. **Document custom checks** in project README
6. **Use IDE integrations** for real-time feedback (ESLint, Prettier plugins)

## Summary Checklist

### JavaScript/TypeScript Projects

Before every push, verify:

- ✅ Prettier formatting applied
- ✅ ESLint passes with no errors
- ✅ TypeScript type checking passes (if applicable)
- ✅ All tests pass
- ✅ Build completes successfully
- ✅ No console errors or warnings in build output
- ✅ Changes committed with proper commit message
- ✅ On correct feature branch (not main)

### Kotlin/Java Projects

Before every push, verify:

- ✅ ktlint formatting applied
- ✅ detekt passes with no errors
- ✅ All tests pass
- ✅ Gradle build completes successfully
- ✅ No build errors or warnings
- ✅ Changes committed with proper commit message
- ✅ On correct feature branch (not main)

**Remember: Quality checks protect the codebase and save time by catching issues early.**

