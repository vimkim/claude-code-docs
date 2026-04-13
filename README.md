# Claude Code Docs

Offline mirror of the [Claude Code documentation](https://code.claude.com/docs) as markdown files, ready for piping to LLMs.

## Prerequisites

- [just](https://github.com/casey/just)
- [Claude Code CLI](https://claude.ai/code) (for `summarize`, `qa`, `ask` recipes)
- `curl`, `xargs`, `grep`

## Usage

```bash
# Download all English docs
just fetch

# Download Korean docs
just fetch-ko

# Bundle into a single file
just bundle

# Summarize via Claude
just summarize

# Q&A flashcards on specific topics
just qa skills mcp hooks

# Ask Claude about a single doc
just ask permissions.md "explain this in simple terms"

# List downloaded docs
just list

# Clean up
just clean
```

## Structure

```
.
├── justfile
├── llms.txt          # doc index (fetched)
└── en/               # downloaded markdown files
    ├── overview.md
    ├── skills.md
    ├── agent-sdk/
    │   ├── overview.md
    │   └── ...
    └── ...
```
