#!/usr/bin/env bash
set -eo pipefail

# Instala dependencias
mix local.rebar --force
mix local.hex --force
mix deps.get

# Compila assets (si usas Webpack/esbuild)
mix assets.deploy

# Compila el proyecto
mix compile