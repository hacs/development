.DEFAULT_GOAL := help

.PHONY: help
help: ## Shows this message.
	@echo "Development environment for HACS"
	@echo
	@echo "Integration: "
	@printf "\033[36m  make %-30s\033[0m %s\n" "integration-init" "Initialize the integration repository"
	@printf "\033[36m  make %-30s\033[0m %s\n" "integration-start" "Start the HA with the integration"
	@printf "\033[36m  make %-30s\033[0m %s\n" "integration-test" "Run pytest"
	@printf "\033[36m  make %-30s\033[0m %s\n" "integration-update" "Pull master from hacs/integration"
	@echo
	@echo "Frontend: "
	@printf "\033[36m  make %-30s\033[0m %s\n" "frontend-init" "Initialize the frontend repository"
	@printf "\033[36m  make %-30s\033[0m %s\n" "frontend-start" "Start the frontend"
	@printf "\033[36m  make %-30s\033[0m %s\n" "frontend-build" "Build the frontend"
	@printf "\033[36m  make %-30s\033[0m %s\n" "frontend-update" "Pull master from hacs/frontend"
	@echo
	@echo "Documentation: "
	@printf "\033[36m  make %-30s\033[0m %s\n" "documentation-init" "Initialize the documentation repository"
	@printf "\033[36m  make %-30s\033[0m %s\n" "documentation-start" "Start a local server for the documentation"
	@printf "\033[36m  make %-30s\033[0m %s\n" "documentation-update" "Pull master from hacs/documentation"
	@echo
	@echo "Default: "
	@printf "\033[36m  make %-30s\033[0m %s\n" "default-init" "Initialize the default repository"
	@printf "\033[36m  make %-30s\033[0m %s\n" "default-add" "Add a new repository to the default HACS list"
	@printf "\033[36m  make %-30s\033[0m %s\n" "default-remove" "Remove a repository to the default HACS list"
	@printf "\033[36m  make %-30s\033[0m %s\n" "default-update" "Pull master from hacs/default"
	@echo
	@echo "Misc: "
	@printf "\033[36m  make %-30s\033[0m %s\n" "homeassistant-install" "IInstall the latest dev version of Home Assistant"
	@printf "\033[36m  make %-30s\033[0m %s\n" "homeassistant-update" "Alias for 'homeassistant-install'"
	@printf "\033[36m  make %-30s\033[0m %s\n" "development-update" "Pull master from hacs/development"
	@printf "\033[36m  make %-30s\033[0m %s\n" "clean" "Delete all repositories"
	@echo


# Integration
integration-init: development-init homeassistant-install
	@bash script/repository_init integration
	@bash script/integration_init

integration-start:
	@bash script/integration_start

integration-test:
	@bash script/integration_test

integration-update:
	@bash script/integration_update


# Frontend
frontend-init: development-init
	@bash script/repository_init frontend
	@bash script/frontend_init

frontend-start:
	@bash script/frontend_start

frontend-build:
	@bash script/frontend_build

frontend-update:
	@bash script/frontend_update


# Documentation
documentation-init: development-init
	@bash script/repository_init documentation
	@bash script/documentation_init

documentation-start:
	@bash script/documenation_start

documentation-update:
	@bash script/documentation_update

# Default
default-init: development-init
	@bash script/repository_init default

default-add:
	@bash script/default_add

default-remove:
	@bash script/default_remove

default-update:
	@bash script/default_update


# Misc
homeassistant-install:
	@bash script/homeassistant_install;

homeassistant-update: homeassistant-install;

development-init:
	@bash script/development_init

development-update:
	@bash script/development_update

clean:
	rm -rf repositories
	rm -rf /tmp/config