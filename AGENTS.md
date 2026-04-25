# Project: Python Template (AI-Assisted Development)

## Tech Stack

- **Python 3.13** with **uv** package manager
- **Ruff** — linting + formatting (replaces black, isort, flake8)
- **pytest** — testing
- **pyright** — static type checking

## Commands

```bash
# Format code
uv run ruff format .

# Lint code
uv run ruff check .

# Auto-fix lint issues
uv run ruff check --fix .

# Type check
uv run pyright

# Run tests
uv run pytest

# Run tests with coverage
uv run pytest -v

# Full quality check (run before committing)
uv run ruff format . && uv run ruff check . && uv run pyright && uv run pytest
```

## Coding Conventions

- **Type annotations required** on all function signatures (parameters and return types)
- **snake_case** for variables and functions, **PascalCase** for classes
- Follow Ruff rules — do not suppress warnings without justification
- Prefer `pathlib.Path` over `os.path`
- Use f-strings for string formatting
- Prefer `from __future__ import annotations` for forward references
- Write docstrings only for public module-level functions and classes; keep them to one line

## Project Structure

### Simple Script

Keep it flat:

```
project/
├── main.py
├── helper.py (if needed)
└── tests/
```

- Single file or a few files at the root
- `uv run main.py` to execute
- Add type annotations and minimal docstrings

### Web Project (DDD + FastAPI)

When building a web project, use Domain-Driven Design with FastAPI:

```
project/
├── domain/           # Pure business logic, no external dependencies
│   ├── entities.py       # Domain entities
│   ├── value_objects.py  # Value objects
│   ├── services.py       # Domain services
│   └── repositories.py   # Repository interfaces (abstract classes)
├── application/      # Use cases, orchestrates domain objects
│   ├── dtos.py           # Data Transfer Objects (Pydantic models)
│   └── services.py       # Application services / use cases
├── infrastructure/   # External concerns
│   ├── repositories.py   # Repository implementations (DB, etc.)
│   └── external.py       # External service clients
├── interfaces/       # Entry points
│   ├── api/
│   │   ├── routers/      # FastAPI routers grouped by domain
│   │   ├── schemas.py    # Request/Response Pydantic models
│   │   └── dependencies.py # FastAPI dependencies (Depends)
│   └── main.py           # FastAPI app factory
├── tests/
└── pyproject.toml
```

#### FastAPI Best Practices

- Use `async def` by default; only use `def` for blocking I/O
- Group routes by domain into separate router modules
- Use Pydantic v2 models for request/response validation
- Use `Annotated` pattern with `Depends` for dependency injection
- Handle cross-cutting concerns via middleware (logging, error handling, CORS)
- Use dependency injection for repository/services — never import implementations directly in routers
- Keep routers thin: parse request → call application service → return response
- Application services contain business logic; routers only handle HTTP concerns

#### Adding FastAPI

```bash
uv add fastapi uvicorn
```

Then create the app structure following the DDD layout above.

## Testing

- Place tests in `tests/` mirroring the source structure
- Use pytest fixtures for setup; keep fixtures close to where they're used
- For web projects: use `httpx.AsyncClient` with FastAPI's `TestClient` pattern
- For domain/application layer: unit tests with no external dependencies
- For infrastructure layer: integration tests with real or test databases
- Test file naming: `test_<module_name>.py`

## Quality Gates

Before committing, all of these must pass:

1. `uv run ruff format .` — no formatting changes needed
2. `uv run ruff check .` — no lint errors
3. `uv run pyright` — no type errors
4. `uv run pytest` — all tests pass
