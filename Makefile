MAKEFLAGS += --no-print-directory
.DEFAULT_GOAL := help

integration-init: development-init homeassistant-install
	@ cd repositories && 	gh repo fork hacs/integration --clone=true --remote=true;
	- cd repositories/documentation && ${MAKE} --no-print-directory init;

frontend-init: development-init
	@ cd repositories && 	gh repo fork hacs/frontend --clone=true --remote=true;
	- cd repositories/documentation && ${MAKE} --no-print-directory init;

documentation-init: development-init
	@ cd repositories && 	gh repo fork hacs/documentation --clone=true --remote=true;
	- cd repositories/documentation && ${MAKE} --no-print-directory init

default-init: development-init
	@ cd repositories && 	gh repo fork hacs/default --clone=true --remote=true;
	@ cd repositories/default && ${MAKE} --no-print-directory init


integration-%:
	@ cd repositories/integration && ${MAKE} --no-print-directory $(subst integration-,,$@)

frontend-%:
	@ cd repositories/frontend && ${MAKE} --no-print-directory $(subst frontend-,,$@)

documentation-%:
	@ cd repositories/documentation && ${MAKE} --no-print-directory $(subst documentation-,,$@)

default-%:
	@ cd repositories/default && ${MAKE} --no-print-directory $(subst default-,,$@)


##@ Misc:
homeassistant-install: ## Install the latest dev version of Home Assistant
	python -m pip --disable-pip-version-check install -U setuptools wheel
	python -m pip --disable-pip-version-check \
		install --upgrade git+git://github.com/home-assistant/home-assistant.git@dev;

homeassistant-update: homeassistant-install ## Alias for 'homeassistant-install'

init: gh-cli
	@bash completion

development-init:
	@ if [ -d ".git" ]; then mv .git ..git; fi

pull: ## Pull master from hacs/development
	@ mv ..git .git;
	@ git pull upstream master;
	@ mv .git ..git;


clean: ## Delete all repositories
	rm -rf repositories;
	rm -rf /tmp/config;

gh-cli:
	apk add go;
	git clone https://github.com/cli/cli.git /srv/gh-cli;
	cd /srv/gh-cli && make;
	mv /srv/gh-cli/bin/gh /usr/local/bin/;
	@bash -c "if [[ $$(git remote get-url origin) == *'git@github'* ]]; then gh config set git_protocol ssh; fi";

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[0m \n" "Development environment for" "HACS";

	@printf "\n\033[1m%s\033[0m\n" Integration;
	@if test -f repositories/integration/Makefile; then cat repositories/integration/Makefile | awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make integration-%-10s\033[0m %s\n", $$1, $$2 }';	else printf " \033[36m make integration-%-10s\033[0m %s\n" "init" "Initialize the integration repository";fi;

	@printf "\n\033[1m%s\033[0m\n" Frontend;
	@if test -f repositories/frontend/Makefile; then cat repositories/frontend/Makefile | awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make frontend-%-10s\033[0m %s\n", $$1, $$2 }';	else printf " \033[36m make frontend-%-10s\033[0m %s\n" "init" "Initialize the frontend repository";fi;

	@printf "\n\033[1m%s\033[0m\n" Documentation;
	@if test -f repositories/documentation/Makefile; then cat repositories/documentation/Makefile | awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make documentation-%-10s\033[0m %s\n", $$1, $$2 }';	else printf " \033[36m make documentation-%-10s\033[0m %s\n" "init" "Initialize the documentation repository";fi;

	@printf "\n\033[1m%s\033[0m\n" Default;
	@if test -f repositories/default/Makefile; then cat repositories/default/Makefile | awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make default-%-10s\033[0m %s\n", $$1, $$2 }';	else printf " \033[36m make default-%-10s\033[0m %s\n" "init" "Initialize the default repository";fi;

	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo