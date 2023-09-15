SHELL := /bin/bash

help:
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

ifndef LIGO
LIGO=docker run -u $(id -u):$(id -g) --rm -v "$(PWD)":"$(PWD)" -w "$(PWD)" ligolang/ligo:0.55.0
endif
# ^ use LIGO en var bin if configured, otherwise use docker

compile = $(LIGO) compile contract --project-root ./lib ./lib/$(1) -o ./compiled/$(2) $(3) 
# ^ Compile contracts to Michelson or Micheline

test = @$(LIGO) run test $(project_root) ./test/$(1)
# ^ run given test file


.PHONY: test
test: ## run tests (SUITE=single_asset make test)
ifndef SUITE
	@$(call test,single_asset.test.mligo)
	@$(call test,single_asset.extended.test.mligo)
	@$(call test,multi_asset.test.mligo)
else
	@$(call test,$(SUITE).test.mligo)
endif

publish: ## publish package on packages.ligolang.org
	@$(LIGO) publish