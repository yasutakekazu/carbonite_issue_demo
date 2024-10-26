defmodule CarboniteIssueDemo.Repo.Migrations.InstallCarbonite do
  use Ecto.Migration

  def up do
    Carbonite.Migrations.up(1..11)
    Carbonite.Migrations.create_trigger("notes")
  end

  def down do
    Carbonite.Migrations.drop_trigger("notes")
    Carbonite.Migrations.down(11..1)
  end
end
