defmodule Photography.Repo.Migrations.AddNameUniqueness do
  use Ecto.Migration

  def change do
    create unique_index(:photos, [:name])
  end
end
