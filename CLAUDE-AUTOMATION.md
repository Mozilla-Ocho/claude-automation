# CLAUDE-AUTOMATION.md

This file describes the resources such as commands, agents, scripts, etc. that should manage the development workflow in this project.

## Note about Names

CHANGE references to "Carmen" throughout this repo to the name of your project and adjust the Carmen-specific items (especially those related to the tech stack ) to make them appropriate for your project.

## Guidelines

- Conciseness counts. In all interactions, pr titles, and commit messages, be extremely concise and sacrifice grammar for the sake of conciseness.
- Identify unresolved questions. At the end of any plan or design, output a list of unresolved questions whose answers would make the plan more precise.

## Development Commands

### Linear commands

- We track our issues in Linear, a project management tool
- The issue id follows the format "CAR-[number]". ALWAYS reference issues by their issue id.
- ALWAYS associate issues with the **Carmen** project under the **Carmen** team
- Most issue tracking actions can be done using the linearis command:
  - **List all issues** `linearis issues list`
  - **View issue and comments** `linearis issues read CAR-XXXX`
  - **Update issue status**: `linearis issues update --state "To Do" CAR-XXXX`
  - **Add Comment**: `linearis comments create --body "my comment" CAR-XXXX`
- For updating comments, use these scripts:
  - **Update Comment**: `scripts/update-linear-comment.sh <comment-id> "comment body"`
  - **Attach Image to Comment**: `scripts/attach-image-to-linear-comment.sh <comment-id> <image-file-path>`

### Best Practices & Coding Guidelines

WHen creating, editing and reviewing files in this rep, follow the practices described in @docs/BEST-PRACTICES.md

### Code Exploration Guidelines

Both `index-analyzer` and `Explore` subagents have access to PROJECT_INDEX.json, which contains:

- Directory structure
- File locations
- Function names and signatures
- Function locations/line numbers
- Function call graph

**Use `index-analyzer` for structure/architecture questions:**

- "Where is function X defined?"
- "Locate all references to function X"
- "What calls function Y?"
- "Show me the directory structure"
- "What are all the service files?"
- Any query about code organization, relationships, or call graphs

**Use `Explore` for semantic/content questions:**

- "How does error handling work?"
- "Where is authentication implemented?"
- "Find all TODO comments"
- "How do we manage user sessions?"
- Any query about implementation details, patterns, or business logic

Launch subagents via the Task tool with `subagent_type=index-analyzer` or `subagent_type=Explore`.

