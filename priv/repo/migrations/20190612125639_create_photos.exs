defmodule Photography.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :name, :string
      add :image, :string
      add :shutterspeed, :string
      add :iso, :integer
      add :aperture, :string
      add :lense, :string
      add :description, :string

      timestamps()
    end

  end
end
