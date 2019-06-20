defmodule Photography.Repo.Migrations.AddUuidToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :uuid, :string
    end
  end
end
