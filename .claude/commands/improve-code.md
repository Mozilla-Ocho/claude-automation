---
allowed-tools: Read, Edit, Write, Grep, Glob, Bash
argument-hint: [file-path] | [directory-path] (optional - defaults to recent changes)
description: Improve code quality by applying best practices and fixing issues
---

# Code Quality Improvement

Improve code quality in: ${ARGUMENTS:-recent changes in the working directory} by applying software engineering best practices and guidelines from @docs/BEST-PRACTICES.md.

## Scope

${ARGUMENTS:+Target: @$ARGUMENTS}${ARGUMENTS:-All modified and untracked files from git status}

## Process

1. **Identify files** based on ${ARGUMENTS:-git status}
2. **Analyze each file** against coding guidelines
3. **Apply fixes** automatically where safe
4. **Report changes** made with rationale

## Improvements Applied

### TypeScript Best Practices

- Add missing type annotations (avoid `any`)
- Use interfaces over types where appropriate
- Add proper null/undefined checks
- Use satisfies operator for type validation
- Fix type inference issues

### React/Next.js Patterns

- Convert to Server Components where possible
- Remove unnecessary 'use client' directives
- Add proper error boundaries
- Implement Suspense for async operations
- Optimize async API usage (cookies, headers, params)
- Fix prop destructuring in pages/layouts

### Code Quality

- Extract magic numbers to named constants
- Simplify complex conditionals
- Implement early returns for readability
- Remove duplicate code (DRY principle)
- Improve naming (isLoading, hasError, handleClick)
- Add missing JSDoc comments for complex functions

### Performance

- Add lazy loading to images below fold
- Fix unnecessary re-renders (useMemo, useCallback)
- Optimize database queries (N+1 issues)
- Add proper React Query staleTime configuration

### Security

- Add input validation with Zod schemas
- Add XSS sanitization where needed
- Fix potential SQL injection risks
- Add authentication checks to server actions
- Validate user permissions

### Styling

- Consolidate Tailwind classes
- Use Radix responsive props correctly
- Fix accessibility issues (ARIA, alt text)
- Ensure keyboard navigation support

### Testing

- Add missing test cases for edge cases
- Fix test isolation issues
- Improve mock patterns
- Add integration tests where needed

## Safety Guidelines

- Only make changes that are clearly improvements
- Preserve existing functionality
- Don't refactor stable, working code unnecessarily
- Test changes after making them (run eslint, tsc)
- Ask for confirmation on significant architectural changes

## Verification Steps

After improvements, run:

1. `npm run eslint:fix` - Fix formatting
2. `npm run tsc` - Check types
3. `npm run test:unit` - Run unit tests
4. Review changes with user before committing

## Output Format

For each file improved:

**File**: `path/to/file.ts`

**Changes Made**:
    - Change 1 description (line X)
    - Change 2 description (line Y)

**Rationale**: Why these changes improve code quality

**Verification**: ✓ ESLint passed, ✓ TypeScript passed
