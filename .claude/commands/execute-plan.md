# Execute Work for Addressing Linear Issue

Execute the work for addressing the specified Linear issue

## Usage

```claudecode
/execute-plan <issue-id>
```

- `<issue-id>`: The id of the issue in Linear that is being implemented.

## Signing In To App

If you need to sign in to an account, you can visit <http://carmen.blog.localhost:3000/auth/login> using email <test-user-issues@example.org> and password test-user-issues

## Development Workflow

### Important Guidelines

- **Use Workflow Steps**: ALWAYS follow the workflow below unless explicitly told otherwise. **Never** skip a step unless directed.

- **TodoWrite list**: When starting work on an issue, IMMEDIATELY create a TodoWrite list with all these steps as individual todos. Mark each as completed as you progress to ensure no steps are missed.

- **Halt on Error**: If any step fails, output a message to the user and HALT. Do NOT continue to the next step.

### Workflow Steps

1. **Fetch issue details**
    - Get latest issue details from Linear (may have changed since last viewed)
    - If no issue with the specified id exists in Linear, warn the user and HALT.
    - If the issue information lacks a comment titled "IMPLEMENTATION PLAN", then warn the user and HALT.
    - Update status to "In Progress" if not already set

1. **Gather context**
    - Search @doc/ folder for relevant information
    - If a Figma link present in the issue description, fetch the associated info from Figma MCP server

1. **Switch to correct branch**
    - Run `scripts/ensure-correct-branch <issue-id>` This script will create the new branch for the issue or switch to it if it already exists.

1. **Implement feature and tests**
    - Following the plan described in the issue comment titled "IMPLEMENTATION PLAN", implement the feature/fix.
    - Create/update/remove tests as needed to cover new behavior.
    - Fix failures in new/updated tests until they pass

1. **Check types and formatting**
   - Run `docker exec -it nextjs_app sh -c "npm run eslint:fix"`
   - Run `docker exec -it nextjs_app sh -c "npm run tsc"`
   - Fix any linting/TypeScript errors and re-run until clean

1. **Run test suite**
    - Run `docker exec -it nextjs_app sh -c "npm run test"`
    - If applicable, run selected end-to-end tests, including any of the following that are related to the issue (these should be run locally, not in the docker container):
        - `npm run test:e2e:static-pages`
        - `npm run test:e2e:onboarding`
        - `npm run test:e2e:dashboard`
        - `npm run test:e2e:blog-posts`
    - Fix failures until all tests pass (display coverage)
    - If appropriate, update tests to incorporate new or removed behavior
    - NEVER proceed with failing tests

1. **Take post-change screenshot(s)** (if needed)
    - If the issue had a pre-change screenshot, then:
        - use Playwright MCP to capture post-change screenshot(s)
        - confirm appearance is as expected post-change
        - create a comment in issue
            - title the comment "POST-CHANGE SCREENSHOT"
            - If referring to the image in the text of this comment, do NOT refer to the image by filename but simply use the phrase "See attached image below"
            - after the comment is created, attach screenshot image(s) to the comment

1. **Verify build**
    - Run `docker exec -it nextjs_app sh -c "npm run build" && docker compose restart web`
    - Fix all build issues before proceeding.

1. **Update documentation**
    - When code changes affect core functionality, commands, or setup procedures, ALWAYS update relevant documentation (README.md, docs/*.md).

1. **Commit changes**
    - Stage all changes with `git add`
    - Commit with concise message with 3-15 words
    - Never create PR without committing first

1. **Create pull request**
    - Use format: `[issue-id] Issue Title`
    - Add PR URL as comment in Linear issue
    - For title, ALWAYS use `[<issue-id>] Issue Title` (e.g., `[CAR-24] Add .claude to .gitignore`).
    - For description, explain the changes, their purpose, and any relevant context.

1. **Review code**
    - Self-review the PR focusing on the following:
        - Code quality and best practices (see docs/BEST-PRACTICES.md)
        - Potential bugs or issues
        - Potential improvements
        - Performance considerations
        - Security implications
        - Test coverage
        - Documentation updates if needed
    - Provide constructive feedback with specific suggestions for improvement.
    - ALWAYS use inline comments to highlight specific areas of concern.

1. **Update status**
    - Change Linear issue status to "Needs Review"
