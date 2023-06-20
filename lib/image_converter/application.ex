defmodule ImageConverter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ImageConverterWeb.Telemetry,
      # Start the Ecto repository
      ImageConverter.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImageConverter.PubSub},
      # Start Finch
      {Finch, name: ImageConverter.Finch},
      # Start the Endpoint (http/https)
      ImageConverterWeb.Endpoint
      # Start a worker by calling: ImageConverter.Worker.start_link(arg)
      # {ImageConverter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImageConverter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImageConverterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
