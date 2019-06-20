defmodule Photography.Repo.Migrations.ChangeUuidForSlugSecondAttempt do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      remove :uuid
      add :slug, :string
    end
  end
end
