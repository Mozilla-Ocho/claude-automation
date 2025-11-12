---
allowed-tools: Read, Grep, Glob, Bash
argument-hint: [file-path] | [directory-path] | [commit-id] (optional - defaults to recent changes)
description: Review code for quality, security, performance, and best practices
---

# Code Review

Perform a comprehensive code review of: ${ARGUMENTS:-recent changes in the working directory}.

## Scope

${ARGUMENTS:+Review target: @$ARGUMENTS}${ARGUMENTS:-Review all modified and untracked files from git status}

## Review Process

I'll analyze the code and provide feedback on compliance with @docs/BEST-PRACTICES.md

## Review Steps

1. Identify files to review based on ${ARGUMENTS:-git status}
2. Read and analyze each file
3. Cross-reference with related files for context
4. Check against project guidelines @BEST-PRACTICES.md
5. Provide actionable feedback with specific line references

## Output Format

For each file reviewed, provide:

- **File**: `path/to/file.ts:line_number`
- **Severity**: Critical | High | Medium | Low | Suggestion
- **Category**: Security | Performance | Quality | Best Practice
- **Issue**: Clear description of the problem
- **Recommendation**: Specific fix or improvement
- **Example** (if helpful): Code snippet showing the improvement

## Focus Areas Based on File Type

### TypeScript/JavaScript

- Type safety and null checks
- Async/await error handling
- Function complexity and size
- Import organization

### React/Next.js

- Component composition
- State management patterns
- Server vs client components
- Data fetching strategies
- Cache invalidation

### Database (Prisma)

- Query efficiency
- Proper use of transactions
- Data validation
- Migration safety

### Tests

- Test coverage completeness
- Proper mocking strategies
- Test isolation and cleanup
- Meaningful assertions

## Priority

Focus on critical issues first:

1. Security vulnerabilities
2. Bugs and logic errors
3. Performance bottlenecks
4. Code quality improvements
