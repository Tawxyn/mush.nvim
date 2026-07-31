NVIM ?= nvim

.PHONY: test
test:
	$(NVIM) --clean --headless -u tests/minimal_init.lua -l tests/run.lua
