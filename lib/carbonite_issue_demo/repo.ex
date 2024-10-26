defmodule CarboniteIssueDemo.Repo do
  use Ecto.Repo,
    otp_app: :carbonite_issue_demo,
    adapter: Ecto.Adapters.Postgres
end
