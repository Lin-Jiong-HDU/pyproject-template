# Python Project Template

> Full AI protocol: see `CLAUDE.md`

## Tech Stack
- Python 3.13 + uv (package manager)
- Ruff (lint + format), pytest, pyright

## Repo Defaults
- Source layout: flat (files at root, no `src/`)
- Config: `pyproject.toml` is the single source of truth
- Package manager: `uv run <cmd>`; never `pip install` directly
- Lock file: `uv.lock` — commit it; `uv sync --group dev` to reproduce

## Commands
- Install: `uv sync --group dev`
- Format: `uv run ruff format .`
- Lint: `uv run ruff check .`
- Type check: `uv run pyright`
- Test: `uv run pytest`
- Full check: `make ci`

## Debugging Protocol
1. Reproduce: `uv run pytest tests/test_foo.py::test_name -v`
2. Locate: read error + traceback, relevant code only
3. Minimal fix: fewest lines changed; no unrelated refactoring
4. Add regression test
5. Verify: `make ci`

## Change Policy
- Default: minimal changes only
- No unrequested refactoring
- Justify any `# noqa` or `# type: ignore` inline

## Rules
- Type annotations required on all function signatures
- snake_case for variables/functions, PascalCase for classes
- Follow Ruff rules
- Prefer pathlib.Path, f-strings, async def by default
- Write one-line docstrings only for public functions/classes

## Web Projects (DDD + FastAPI)
When building a web API:
- `domain/` — entities, value objects, services, repository interfaces (no external deps)
- `application/` — use cases, DTOs (Pydantic)
- `infrastructure/` — repository implementations, external services
- `interfaces/api/` — FastAPI routers, schemas, dependencies
- Use Depends for DI, Pydantic v2 for validation, async-first
- Keep routers thin, business logic in application services
- Add FastAPI: `uv add fastapi uvicorn`

## Quality Gates (must pass before commit)
1. ruff format — no changes needed
2. ruff check — no errors
3. pyright — no type errors
4. pytest — all tests pass
