FROM elixir:1.14.5

WORKDIR /app

# Configuración esencial
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    MIX_ENV=prod \
    PHX_SERVER=true \
    DATABASE_URL=""

# Instalación mínima de dependencias del sistema
# Con reintentos automáticos y manejo de errores
RUN for i in {1..3}; do \
      apt-get update && \
      apt-get install -y --no-install-recommends \
      git \
      ca-certificates \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* \
      && break; \
    done

# Configuración de Elixir
RUN mix local.hex --force && \
    mix local.rebar --force

# Instalación de dependencias de Elixir
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod && \
    mix deps.compile

# Copia de archivos
COPY assets assets
COPY priv priv
COPY lib lib
COPY config config
COPY priv/static /app/priv/static


# Construcción condicional de assets
RUN if [ -f "assets/package.json" ]; then \
      cd assets && \
      npm install --no-audit --progress=false && \
      { npm run deploy || true; } && \
      cd .. && \
      mix phx.digest; \
    fi



# Compilación final
RUN mix compile

EXPOSE 4000
CMD ["mix", "phx.server"]