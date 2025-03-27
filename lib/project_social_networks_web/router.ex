defmodule ProjectSocialNetworksWeb.Router do
  use ProjectSocialNetworksWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ProjectSocialNetworksWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProjectSocialNetworksWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", ThoughtLive, :home       # Ruta principal
    # live "/pensamientos", ThoughtLive  # Ruta alternativa (opcional)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProjectSocialNetworksWeb do
  #   pipe_through :api
  # end

  if Application.compile_env(:project_social_networks, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live "/", ThoughtLive, :index
      live_dashboard "/dashboard", metrics: ProjectSocialNetworksWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
