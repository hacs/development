# HACS Development

This repository contains all you need to contribute to the HACS project.

## Usage

1. Install and configure [gh CLI](https://github.com/cli/cli) on the host.
1. Fork this repository.
1. Clone the repository locally.
1. Start the devcontainer.
1. Run `make help` to list all available commands.

```bash
container# make help
Development environment for HACS 

Integration
  make integration-init       Initialize the integration repository

Frontend
  make frontend-init          Initialize the frontend repository

Documentation
  make documentation-init     Initialize the documentation repository

Default
  make default-init           Initialize the default repository

Misc:
  make homeassistant-install  Install the latest dev version of Home Assistant
  make homeassistant-update  Alias for 'homeassistant-install'
  make pull        Pull master from hacs/development
  make clean       Delete all repositories
  make help        Shows help message.
```
