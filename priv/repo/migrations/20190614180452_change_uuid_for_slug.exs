defmodule Photography.Repo.Migrations.ChangeUuidForSlug do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      remove :uuid
      add :uuid, :string
    end
  end
end
