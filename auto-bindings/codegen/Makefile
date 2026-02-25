.PHONY: clean test tdd

clean:
	rm -rf .coverage .pytest_cache */__pycache__
	find . -name __pycache__ -type d -print0 | xargs -r0 rm -r

test:
	uv run pytest \
	  --cov=src/codegen \
		--cov-report term-missing:skip-covered \
		--cov-branch \
		--durations=0

tdd:
	uv run ptw . \
	  --cov=src/codegen \
		--cov-report term-missing:skip-covered \
		--cov-branch
