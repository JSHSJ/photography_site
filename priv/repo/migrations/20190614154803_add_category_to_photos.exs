defmodule Photography.Repo.Migrations.AddCategoryToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :category, :string
    end
  end
end
