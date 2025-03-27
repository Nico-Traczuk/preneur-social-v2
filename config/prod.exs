
  import Config

  config :project_social_networks, ProjectSocialNetworksWeb.Endpoint,
    url: [host: System.get_env("PHX_HOST") || "challenge-prenuer.gigalixirapp.com", port: 4000],
    http: [
      ip: {0, 0, 0, 0},  # ¡Añade esta línea!
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    cache_static_manifest: "priv/static/cache_manifest.json",
    server: true,  # ¡Crucial para LiveView!
    secret_key_base: System.get_env("SECRET_KEY_BASE"),
    check_origin: ["//*.gigalixirapp.com", "//challenge-prenuer.gigalixirapp.com"]

  # Configuración de Swoosh
  config :swoosh,
    api_client: Swoosh.ApiClient.Finch,
    finch_name: ProjectSocialNetworks.Finch,
    local: false

  # Logger
  config :logger, level: :info

  # Configuración importante para producción
  config :phoenix, :serve_endpoints, true
  config :phoenix, :filter_parameters, ["password", "secret"]
