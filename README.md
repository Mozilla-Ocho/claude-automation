# claude-automation

This repo contains scripts and configuration files for automatic development of a Next.js app. These items were extracted from [the Carmen project](https://github.com/Mozilla-Ocho/carmen/).

## One-time setup

Ensure tools are installed and configured:

```bash
brew install jq
npm install -g linearis@latest
echo -n "Enter the Linear API token: "
read -s LINEAR_API_TOKEN
echo "LINEAR_API_TOKEN=${LINEAR_API_TOKEN}" >> ~/.zshrc
```

## Copy files

You can copy these files as is into your project's repo.

## Items for CLAUDE.md

In your project's CLAUDE.md file, either include [CLAUDE-AUTOMATION.md](./CLAUDE-AUTOMATION.md) with @CLAUDE-AUTOMATION.md or paste the contents directly into CLAUDE.md.
