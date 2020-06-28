# HACS Development

This repository contains all you need to contribute to the HACS project.

## Usage

1. Fork this repository.
1. Clone the repository locally.
1. Start the devcontainer.
1. Run `make help` to list all available commands.

```bash
container# make help
Development environment for HACS

Integration:
  make integration-init               Initialize the integration repository
  make integration-start              Start the HA with the integration
  make integration-test               Run pytest
  make integration-update             Pull master from hacs/integration

Frontend:
  make frontend-init                  Initialize the frontend repository
  make frontend-start                 Start the frontend
  make frontend-build                 Build the frontend
  make frontend-update                Pull master from hacs/frontend

Documentation:
  make documentation-init             Initialize the documentation repository
  make documentation-start            Start a local server for the documentation
  make documentation-update           Pull master from hacs/documentation

Default:
  make default-init                   Initialize the default repository
  make default-add                    Add a new repository to the default HACS list
  make default-remove                 Remove a repository to the default HACS list
  make default-update                 Pull master from hacs/default

Misc:
  make homeassistant-install          IInstall the latest dev version of Home Assistant
  make homeassistant-update           Alias for 'homeassistant-install'
  make development-update             Pull master from hacs/development
  make clean                          Delete all repositories
```
