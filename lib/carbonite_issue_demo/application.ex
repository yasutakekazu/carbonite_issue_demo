defmodule CarboniteIssueDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CarboniteIssueDemoWeb.Telemetry,
      CarboniteIssueDemo.Repo,
      {DNSCluster, query: Application.get_env(:carbonite_issue_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CarboniteIssueDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CarboniteIssueDemo.Finch},
      # Start a worker by calling: CarboniteIssueDemo.Worker.start_link(arg)
      # {CarboniteIssueDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      CarboniteIssueDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CarboniteIssueDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CarboniteIssueDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
