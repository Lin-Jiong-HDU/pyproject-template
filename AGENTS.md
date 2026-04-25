# Project: Python Template (AI-Assisted Development)

## Repo Defaults

- **Source layout**: Flat — source files live at the project root (no `src/` prefix)
- **Test layout**: `tests/` directory, file names `test_<module>.py`
- **Config source of truth**: `pyproject.toml` — ruff, pytest, and pyright are all configured there; `pyrightconfig.json` only sets the venv path
- **Python version**: 3.13 (pinned in `.python-version` and `pyproject.toml`)
- **Package manager**: `uv` — always use `uv run <cmd>`; never `pip install` directly
- **Lock file**: `uv.lock` — commit it; run `uv sync --group dev` to reproduce the environment

## Tech Stack

- **Python 3.13** with **uv** package manager
- **Ruff** — linting + formatting (replaces black, isort, flake8)
- **pytest** — testing
- **pyright** — static type checking

## Commands

```bash
# Install dependencies
uv sync --group dev

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

# Run specific test verbosely
uv run pytest tests/test_foo.py::test_name -v

# Full quality check (run before committing) — also: make ci
uv run ruff format . && uv run ruff check . && uv run pyright && uv run pytest
```

Use `make ci` as a one-command shortcut for the full quality check (see `Makefile`).

## Debugging Protocol

When fixing a bug or failing test, follow these steps **in order**:

1. **Reproduce** — run the failing test or command first:
   ```bash
   uv run pytest tests/test_foo.py::test_name -v  # targeted
   uv run pytest -v                                # full suite
   ```
2. **Locate** — read the error message, traceback, and only the directly relevant code; do not read unrelated files
3. **Minimal fix** — change the fewest lines needed; no unrelated refactoring
4. **Add regression test** — add or update a test that would have caught the bug; if a test already exists, explain why it did not catch it
5. **Verify** — run the full quality gates and confirm all pass:
   ```bash
   uv run ruff format . && uv run ruff check . && uv run pyright && uv run pytest
   ```

## Change Policy

- **Default: minimal changes** — only modify what is required to address the task
- **No unrequested refactoring** — do not rename, reorganize, or restructure code unless explicitly asked
- **Exceptions** — refactoring is allowed only when:
  - It is required to make failing checks pass, OR
  - The user explicitly requests it — state the reason in the response
- **Suppress lint/type errors only as a last resort** — if you must use `# noqa` or `# type: ignore`, add a short inline comment explaining why
- **Public API changes** — always update type hints, docstrings, and related tests together

## What AI Should Include in Responses

After any code change, always include:

1. **What changed** — brief summary of files and lines modified
2. **Commands to run** — the exact commands the user should run to verify:
   ```bash
   uv run pytest tests/test_foo.py -v   # expected: PASSED
   uv run ruff check .                   # expected: All checks passed
   ```
3. **Expected output** — what a successful run looks like
4. **Clarifying questions first** — if the task is ambiguous, ask 1–3 targeted questions before writing any code

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
