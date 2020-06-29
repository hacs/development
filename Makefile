.DEFAULT_GOAL := help

##@ Integration:
integration-init: development-init homeassistant-install ## Initialize the integration repository
	cd repositories && 	gh repo fork hacs/integration --clone=true --remote=true;
	cd repositories/integration && \
		python -m pip --disable-pip-version-check install setuptools wheel && \
		python -m pip --disable-pip-version-check install -r requirements.txt

integration-start: ## Start the HA with the integration
	@bash script/integration_start;

integration-test: ## Run pytest
	cd repositories/integration && python -m pytest;

integration-update: ## Pull master from hacs/integration
	cd repositories/integration && git pull upstream master;


##@ Frontend:
frontend-init: development-init ## Initialize the frontend repository
	cd repositories && 	gh repo fork hacs/frontend --clone=true --remote=true;
	make frontend-bootstrap

frontend-start: ## Start the frontend
	cd repositories/frontend && yarn start;

frontend-bootstrap: ## Run yarn
	cd repositories/frontend && yarn;

frontend-build: ## Build the frontend
	cd repositories/frontend && yarn build;

frontend-update: ## Pull master from hacs/frontend
	cd repositories/frontend && git pull upstream master;


##@ Documentation:
documentation-init: development-init ## Initialize the documentation repository
	cd repositories && 	gh repo fork hacs/documentation --clone=true --remote=true;
	cd repositories/documentation && yarn;

documentation-start: ## Start a local server for the documentation
	cd repositories/documentation && yarn start;

documentation-bootstrap: ## Run yarn
	cd repositories/documentation && yarn;

documentation-build: ## Build the documentation
	cd repositories/documentation && yarn build;

documentation-update: ## Pull master from hacs/documentation
	cd repositories/documentation && git pull upstream master;


##@ Default:
default-init: development-init ## Initialize the default repository
	cd repositories && 	gh repo fork hacs/default --clone=true --remote=true;

default-add: ## Add a new repository to the default HACS list
	@echo not implemented;

default-remove: ## Remove a repository to the default HACS list
	@bash script/default_remove;

default-update: ## Pull master from hacs/default
	cd repositories/default && git pull upstream master;


##@ Misc:
homeassistant-install: ## Install the latest dev version of Home Assistant
	python -m pip --disable-pip-version-check install -U setuptools wheel
	python -m pip --disable-pip-version-check \
		install --upgrade git+git://github.com/home-assistant/home-assistant.git@dev;

homeassistant-update: homeassistant-install ## Alias for 'homeassistant-install'

development-init:
	@ if [ -d ".git" ]; then mv .git ..git; fi

development-update: ## Pull master from hacs/development
	mv ..git .git;
	git pull upstream master;
	mv .git ..git;

clean: ## Delete all repositories
	rm -rf repositories;
	rm -rf /tmp/config;

gh-cli:
	apk add go;
	git clone https://github.com/cli/cli.git /srv/gh-cli;
	cd /srv/gh-cli && make;
	mv /srv/gh-cli/bin/gh /usr/local/bin/;
	@bash -c "if [[ $$(git remote get-url origin) == *'git@github'* ]]; then gh config set git_protocol ssh; fi";

help: ## Shows this message.
	@printf "\033[1m%s\033[36m %s\033[0m \n" "Development environment for" "HACS";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo;
