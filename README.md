# Python Project Template

A minimal, opinionated Python project template optimized for AI-assisted development.

## What This Template Does

Sets up a reproducible Python project with:

- **uv** for fast, deterministic dependency management
- **Ruff** for linting and formatting (replaces black + isort + flake8)
- **pytest** for testing
- **pyright** for static type checking
- **Makefile** for one-command quality checks
- **GitHub Actions CI** that mirrors local quality gates
- **AI instruction files** for Claude, Cursor, GitHub Copilot, and generic agents

Use it as a starting point for scripts, libraries, or web APIs (DDD + FastAPI).

## Quick Start

```bash
# 1. Create a new repo from this template (GitHub UI: "Use this template")
# 2. Clone it locally
git clone https://github.com/your-org/your-project && cd your-project

# 2. Install dependencies
uv sync --group dev

# 3. Run tests
uv run pytest -v

# 4. Run the full quality check
make ci
```

## Development Commands

```bash
make format     # Format code with Ruff
make lint       # Lint with Ruff
make fix        # Auto-fix lint issues
make typecheck  # Type check with pyright
make test       # Run tests with pytest
make ci         # Run all of the above (full quality gate)
```

Or run the underlying `uv run` commands directly — see [CLAUDE.md](CLAUDE.md) for details.

## AI-Assisted Development

This template includes instruction files for AI coding tools:

| File | Tool |
|------|------|
| `CLAUDE.md` | Claude Code |
| `AGENTS.md` | Generic AI agents (Codex, etc.) |
| `.cursorrules` | Cursor |
| `.github/copilot-instructions.md` | GitHub Copilot |

**Recommended AI workflow:**

1. Read `CLAUDE.md` to understand project conventions, the debugging protocol, and change policy
2. Make your changes following the Debugging Protocol in `CLAUDE.md`
3. Run `make ci` to verify all quality gates pass before committing

## License

This template is free to use.
