defmodule MatchcolabMultiselect.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MatchcolabMultiselectWeb.Telemetry,
      MatchcolabMultiselect.Repo,
      {DNSCluster, query: Application.get_env(:matchcolab_multiselect, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MatchcolabMultiselect.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MatchcolabMultiselect.Finch},
      # Start a worker by calling: MatchcolabMultiselect.Worker.start_link(arg)
      # {MatchcolabMultiselect.Worker, arg},
      # Start to serve requests, typically the last entry
      MatchcolabMultiselectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MatchcolabMultiselect.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MatchcolabMultiselectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
