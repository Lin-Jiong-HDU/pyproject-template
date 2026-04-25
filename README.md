# Python Project Template

A minimal Python project template optimized for AI-assisted development.

## What's Included

- **uv** for dependency management
- **Ruff** for linting and formatting
- **pytest** for testing
- **pyright** for type checking
- **AI instruction files** for Claude Code, Cursor, GitHub Copilot, and other AI agents

## Quick Start

1. Click "Use this template" on GitHub to create a new repository
2. Clone your new repository
3. Install dependencies:
   ```bash
   uv sync --group dev
   ```
4. Start coding!

## AI-Assisted Development

This template includes instruction files for AI coding tools:

| File | Tool |
|------|------|
| `CLAUDE.md` | Claude Code |
| `AGENTS.md` | Generic AI agents |
| `.cursorrules` | Cursor |
| `.github/copilot-instructions.md` | GitHub Copilot |

These files contain project conventions, coding standards, and guides for expanding into web projects (DDD + FastAPI).

## Commands

```bash
uv run ruff format .    # Format code
uv run ruff check .     # Lint code
uv run pyright          # Type check
uv run pytest           # Run tests
```

## License

This template is free to use.
