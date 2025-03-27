defmodule ProjectSocialNetworks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjectSocialNetworksWeb.Telemetry,
      # ProjectSocialNetworks.Repo,
      {DNSCluster, query: Application.get_env(:project_social_networks, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjectSocialNetworks.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProjectSocialNetworks.Finch},
      # Start a worker by calling: ProjectSocialNetworks.Worker.start_link(arg)
      # {ProjectSocialNetworks.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjectSocialNetworksWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectSocialNetworks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectSocialNetworksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
