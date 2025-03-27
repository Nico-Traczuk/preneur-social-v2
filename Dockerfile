# --------------------------------------------
# IMAGEN BASE GARANTIZADA (última disponible)
# --------------------------------------------
  FROM elixir:1.14.5

  # --------------------------------------------
  # CONFIGURACIÓN ESENCIAL
  # --------------------------------------------
  WORKDIR /app
  
  ENV LANG=C.UTF-8 \
      LC_ALL=C.UTF-8 \
      MIX_ENV=prod \
      PHX_SERVER=true \
      # Evita problemas con DB inexistente
      DATABASE_URL=""
  
  # --------------------------------------------
  # INSTALACIÓN MÍNIMA
  # --------------------------------------------
  RUN apt-get update && \
      apt-get install -y --no-install-recommends \
      git \
      ca-certificates \
      # Dependencias para assets (si usas Node)
      nodejs \
      npm \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*
  
  # --------------------------------------------
  # CONFIGURACIÓN HEX/REBAR
  # --------------------------------------------
  RUN mix local.hex --force && \
      mix local.rebar --force
  
  # --------------------------------------------
  # INSTALACIÓN DE DEPENDENCIAS
  # --------------------------------------------
  COPY mix.exs mix.lock ./
  RUN mix deps.get --only prod && \
      mix deps.compile
  
  # --------------------------------------------
  # COPIA DE ARCHIVOS (optimizado para caché)
  # --------------------------------------------
  COPY assets assets
  COPY priv priv
  COPY lib lib
  COPY config config
  
  # --------------------------------------------
  # COMPILACIÓN DE ASSETS (si aplica)
  # --------------------------------------------
  RUN cd assets && \
      npm install && \
      npm run deploy && \
      cd .. && \
      mix phx.digest
  
  # --------------------------------------------
  # COMPILACIÓN FINAL
  # --------------------------------------------
  RUN mix compile
  
  # --------------------------------------------
  # CONFIGURACIÓN PARA RENDER
  # --------------------------------------------
  EXPOSE 4000
  CMD ["mix", "phx.server"]