# Technology Stack

This document outlines the primary technologies, frameworks, libraries, and services used in the Carmen project.

## Frontend

- **Framework:** [Next.js](https://nextjs.org/) (v14+ App Router) - React framework for full-stack web applications with server-side rendering and static generation capabilities.
- **Language:** [TypeScript](https://www.typescriptlang.org/) - Superset of JavaScript adding static typing.
- **UI Components:** [Radix UI Themes](https://www.radix-ui.com/themes) - Pre-styled, accessible component library built on Radix Primitives.
- **Styling:** [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS framework for rapid UI development. Used alongside Radix Themes.
- **Rich Text Editor:** [Tiptap](https://tiptap.dev/) (v3.6.2) - Headless wrapper around ProseMirror for building rich text editors.
- **State Management:**
  - React Context API (`UserContext`) - For managing global user authentication state.
  - React Hooks (`useState`, `useCallback`, `useEffect`, `useMemo`, Custom Hooks like `usePostEditor`) - For local and encapsulated state logic.
- **Form Handling:** [React Hook Form](https://react-hook-form.com/) - For managing form state, validation, and submission.
- **Schema Validation (Client & Server):** [Zod](https://zod.dev/) - TypeScript-first schema declaration and validation library.

## Backend / API

- **Runtime:** Node.js (via Next.js API Routes / Server Actions)
- **Language:** TypeScript
- **Authentication:** [NextAuth.js](https://next-auth.js.org/) (Auth.js v5) - Authentication library for Next.js applications.
- **AI Integration:** [Vercel AI SDK](https://sdk.vercel.ai/) - For interacting with AI models (specifically OpenAI).
- **AI Models:** [OpenAI](https://openai.com/) (e.g., GPT-3.5-Turbo, potentially GPT-4) - Used via the Vercel AI SDK for content assistance.

## Database

- **Type:** PostgreSQL
- **Hosting:** Google Cloud SQL
- **Access:** Primarily via custom datastore service (`/server/services/datastoreService.ts`) potentially wrapping a client like `node-postgres` (pg) or an ORM (Prisma - _confirmation needed based on actual implementation_). Connection via private IP and Cloud SQL Auth Proxy managed by Cloud Run annotations.

## Infrastructure & Deployment

- **Cloud Provider:** [Google Cloud Platform (GCP)](https://cloud.google.com/)
- **Hosting:** [Google Cloud Run](https://cloud.google.com/run) - Serverless container hosting.
- **Networking:** GCP VPC Network, Subnets, VPC Access Connector, Cloud Router, Cloud NAT Gateway.
- **Infrastructure as Code (IaC):** [Terraform](https://www.terraform.io/) - For defining and managing GCP resources.
- **Secrets Management:** [Google Secret Manager](https://cloud.google.com/secret-manager) - For securely storing API keys, database passwords, etc.

## Other Tools

- **Linting/Formatting:** ESLint (with rettier plugin)
- **Package Management:** npm / yarn / pnpm (specify which one is standard for the project)
