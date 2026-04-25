# Python Project Template

## Tech Stack
- Python 3.13 + uv (package manager)
- Ruff (lint + format), pytest, pyright

## Commands
- Format: `uv run ruff format .`
- Lint: `uv run ruff check .`
- Type check: `uv run pyright`
- Test: `uv run pytest`
- Full check: `uv run ruff format . && uv run ruff check . && uv run pyright && uv run pytest`

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
