# Plan Work for Addressing Linear Issue

Plan the work for addressing the specified Linear issue

## Usage

```claudecode
/create-plan <issue-id>
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
    - Confirm appearance or behavior is as it is expected to be pre-change.

1. **Take pre-change screenshot** (if needed)
    - Only if the issue involves a change to the app's appearance, then:
        - use Playwright MCP to capture pre-change screenshot
        - confirm appearance is as expected pre-change
        - create a comment in issue
            - title the comment "PRE-CHANGE SCREENSHOT"
            - If referring to the image in the text of this comment, do NOT refer to the image by filename but simply use the phrase "See attached image below"
            - after the comment is created, attach screenshot image to the comment

1. **Ask for UX clarification** (if needed)
    - Create any required clarifying UX questions. Skip to the next step if there are none.
    - If there is already a comment titled  "UX CLARIFICATION" in Linear, replace the contents with this new plan, otherwise create a new comment with these questions titled "UX CLARIFICATION".
    - Wait for a reply to the comment in Linear before proceeding.

1. **Ask for technical clarification** (if needed)
    - Create any required clarifying technical questions. Skip to the next step if there are none.
    - If there is already a comment titled  "TECHNICAL CLARIFICATION" in Linear, replace the contents with this new plan, otherwise create a new comment with these questions titled "TECHNICAL CLARIFICATION".
    - Wait for a reply to the comment in Linear before proceeding.

1. **Create implementation plan**
    - Create an implementation plan, including any changes to tests (additions, changes or deletions)
    - If there is already a comment titled  "IMPLEMENTATION PLAN" in Linear, replace the contents with this new plan, otherwise create a new comment with this plan titled "IMPLEMENTATION PLAN".
    - Get feedback from user and update the implementation plan based on responses
