.PHONY: format lint fix typecheck test ci

format:
	uv run ruff format .

lint:
	uv run ruff check .

fix:
	uv run ruff check --fix .

typecheck:
	uv run pyright

test:
	uv run pytest -v

ci: format lint typecheck test
