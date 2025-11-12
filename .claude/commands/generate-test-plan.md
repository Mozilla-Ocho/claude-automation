---
allowed-tools: Read, Write, Edit, Bash
argument-hint: [file-path] | [component-name] (optional - defaults to entire app)
description: Generate plan for creating a comprehensive test suite with unit, integration, and edge case coverage
---

# Generate 3-Phase Plan for Creating Tests

Generate a phased plan for creating a comprehensive test suite for: ${ARGUMENTS:-the entire Next.js application}. Create a markdown file containing this plan

## Current Testing Setup

- Test framework: Check @jest.config.js, @vitest.config.js, or @package.json
- Existing tests: Use Glob tool to find `**/*.test.*` and `**/*.spec.*` files
- Test scripts: Check @package.json for test:unit, test:integration, test:e2e, test:coverage
- Scope: ${ARGUMENTS:+Target file/component: @$ARGUMENTS}${ARGUMENTS:-Entire Next.js application in this repository}

## Task

I'll analyze the ${ARGUMENTS:-codebase} and generate plan for creating tests with good coverage with the following 3 phases:

1. Unit tests for individual functions and methods
2. Integration tests for component interactions and service layer interactions
3. End-to-end tests for user interaction

## Process

I'll follow these steps:

1. Analyze the ${ARGUMENTS:+target file/component}${ARGUMENTS:-application} structure
2. Identify all testable functions, methods, and behaviors
3. Examine existing test patterns in the project
4. Create a phased plan for doing the following:
    - Create/update test files following project naming conventions
    - Fill in gaps in any existing test files
    - Implement comprehensive test cases with proper setup/teardown
    - Add necessary mocks and test utilities
    - Edge case and error handling tests
    - Test utilities and helpers as needed
    - Verify test coverage and add missing test cases
5. Store the new plan in the file `phased-test-plan.md`. This file should includes a task outline, with each task having a markdown checkbox. This way tasks can be checked off as they are completed.

## Test Types

### Unit Tests

**Typical location**: Alongside implementation files (e.g., `src/**/*.test.ts`)
**Common patterns**:
    - Mock dependencies before importing modules
    - Use test data factories for consistent fixtures
    - Mock authentication/session management
    - Follow existing mock patterns in the project

**Test coverage**:
    - Individual function testing with various inputs
    - Component rendering and prop handling
    - State management and lifecycle methods
    - Utility function edge cases and error conditions

### Integration Tests

**Typical location**: Separate directory (e.g., `tests/integration/*.test.ts`)

**Common patterns**:
    - Test multiple modules/services working together
    - Mock external APIs and services, but NOT internal business logic
    - Mock framework-specific features (caching, revalidation, etc.)
    - Use real database connections or test databases when appropriate

**Test coverage**:
    - Component interaction testing
    - API integration with mocked responses
    - Service layer integration
    - Multi-service workflows

### End-to-End Tests

**Typical location**: Separate directory (e.g., `tests/e2e/*.test.ts`)
**Common patterns**:
    - Complete user workflows with real or simulated authentication
    - Use test helpers for common setup/teardown operations
    - Test critical user paths across multiple pages
    - Use appropriate E2E framework (Playwright, Cypress, etc.)

**Test coverage**:
    - Describe user goals
    - Describe primary user workflows
    - Cover major happy and sad paths for user interaction

## Testing Best Practices

### Test Structure

- Use descriptive test names that explain the behavior
- Group related tests with describe blocks
- Use proper setup and teardown for test isolation

### Mock Strategy

**Project-specific patterns**:
    - Examine existing mocks in `src/**/__tests__/mocks/` or `tests/mocks/`
    - Look for test data factories in `tests/utils/` or similar directories
    - Check for test helpers and custom assertions
    - Follow established patterns for mocking authentication, database, external APIs

**General practices**:
    - Mock external dependencies and API calls
    - Use factories for consistent test data generation
    - Implement proper cleanup for async operations
    - Mock timers and dates for deterministic tests
    - Mock framework-specific features (caching, revalidation, SSR, etc.)

### Coverage Goals

- Aim for 80%+ code coverage
- Focus on critical business logic paths
- Test both happy path and error scenarios
- Include boundary value testing

## Common Testing Patterns to Consider

When analyzing the codebase and creating test plans, consider these patterns:

### Multi-Tenancy & Data Isolation

- Verify data scoping and isolation between tenants/organizations
- Test access control and authorization boundaries
- Ensure users cannot access other tenants' data

### API Integration

- Mock external API responses (AI services, cloud storage, email providers)
- Test error handling for API failures and timeouts
- Verify retry logic and fallback behavior

### Authentication & Authorization

- Test role-based access control
- Verify session handling and token management
- Test authentication flows (login, logout, password reset)
- Ensure protected routes require authentication

### Database Operations

- Test data validation and schema constraints
- Verify transactions and rollback behavior
- Test query performance with realistic data volumes
- Consider using factories for test data consistency

### Framework-Specific Features

    - Cache invalidation and revalidation logic
    - Server-side rendering and data fetching
    - Middleware and request/response transformations
    - Client/server component boundaries (if applicable)
