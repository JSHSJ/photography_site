defmodule Photography.Photos.Photo do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Ecto.UUID

  schema "photos" do
    field :aperture, :string
    field :description, :string
    field :image, Photography.Image.Type
    field :iso, :integer
    field :lense, :string
    field :name, :string
    field :category, :string
    field :shutterspeed, :string
    field :slug, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:name, :shutterspeed, :iso, :aperture, :lense, :description, :category])
    |> validate_required([:name, :shutterspeed, :iso, :aperture, :lense, :description, :category])
    |> unique_constraint(:name)
    |> slugify_name()
    |> check_uuid()
    |> cast_attachments(attrs, [:image])
  end

  defp slugify_name(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, new_name} -> put_change(changeset, :slug, slugify(new_name))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
    |> String.replace("ü", "ue")
    |> String.replace("ä", "ae")
    |> String.replace("ö", "oe")
  end

  defp check_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, UUID.generate())
      _ ->
        changeset
    end
  end
end

defimpl Phoenix.Param, for: Photography.Photos.Photo do
  def to_param(%{slug: slug}) do
    "#{slug}"
  end
end