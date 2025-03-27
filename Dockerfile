# Usa una imagen oficial de Elixir con todo preinstalado
FROM hexpm/elixir:1.15.7-erlang-26.1-debian-bookworm-20240205

WORKDIR /app

# Instala solo lo absolutamente esencial
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configuración UTF-8 (sin locales complejos)
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Copia solo lo necesario
COPY mix.exs mix.lock ./
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

COPY . .

# Compilación final
RUN mix compile && \
    mix assets.deploy