# Usa imagen oficial con tus versiones exactas
FROM debian:bullseye-20240205

# Instala Erlang/Elixir manualmente
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | gpg --dearmor -o /usr/share/keyrings/erlang.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/erlang.gpg] https://packages.erlang-solutions.com/ubuntu bullseye contrib" > /etc/apt/sources.list.d/erlang.list && \
    apt-get update && \
    apt-get install -y esl-erlang=1:25.3-1 elixir=1.14.5-1 && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

# Configuración UTF-8 (soluciona warning de locales)
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    # Evita checks de DB si no la usas
    DATABASE_URL="" \
    # Configuración para Phoenix
    PHX_SERVER=true

# Instalación mínima de dependencias (sin build-essential)
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configura Hex y Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copia archivos de dependencias primero (optimiza caché)
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copia el resto de la aplicación
COPY assets assets
COPY priv priv
COPY lib lib
COPY config config

# Compilación y assets
RUN mix compile && \
    mix assets.deploy && \
    mix phx.digest

# Puerto expuesto (para Render)
EXPOSE 4000

# Comando de inicio (para producción)
CMD ["mix", "phx.server"]