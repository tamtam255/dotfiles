DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore .config
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
XDG_CONF   := $(patsubst .config/%, %, $(wildcard .config/*))
HOME_BIN   := $(patsubst bin/%, %, $(wildcard bin/*))

XDG_CONFIG_HOME ?= $(HOME)/.config
HOME_BIN_DIR ?= $(HOME)/bin

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@$(foreach val, $(XDG_CONF), /bin/ls -dF .config/$(val);)
	@$(foreach val, $(HOME_BIN), /bin/ls -dF bin/$(val);)

deploy: ## Create symlink to home directory
	@echo 'Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@mkdir -p $(XDG_CONFIG_HOME)
	@$(foreach val, $(XDG_CONF), ln -sfnv $(abspath .config/$(val))/ $(XDG_CONFIG_HOME)/$(val);)
	@mkdir -p $(HOME_BIN_DIR)
	@$(foreach val, $(HOME_BIN), ln -sfnv $(abspath bin/$(val)) $(HOME_BIN_DIR)/$(val);)


init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

test: ## Test dotfiles and init scripts
	@#DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/test/test.sh
	@echo "test is inactive temporarily"

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update deploy init ## Run make update, deploy, init
	@exec $$SHELL

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	@-$(foreach val, $(XDG_CONF), rm -vrf $(XDG_CONFIG_HOME)/$(val);)
	@-$(foreach val, $(HOME_BIN), rm -vrf $(HOME_BIN_DIR)/$(val);)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32;1m%-10s\033[0m %s\n", $$1, $$2}'

