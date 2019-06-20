defmodule Photography.PhotosTest do
  use Photography.DataCase

  alias Photography.Photos

  describe "photos" do
    alias Photography.Photos.Photo

    @valid_attrs %{aperture: "some aperture", description: "some description", image: "some image", iso: 42, lense: "some lense", name: "some name", shutterspeed: "some shutterspeed"}
    @update_attrs %{aperture: "some updated aperture", description: "some updated description", image: "some updated image", iso: 43, lense: "some updated lense", name: "some updated name", shutterspeed: "some updated shutterspeed"}
    @invalid_attrs %{aperture: nil, description: nil, image: nil, iso: nil, lense: nil, name: nil, shutterspeed: nil}

    def photo_fixture(attrs \\ %{}) do
      {:ok, photo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Photos.create_photo()

      photo
    end

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Photos.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Photos.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      assert {:ok, %Photo{} = photo} = Photos.create_photo(@valid_attrs)
      assert photo.aperture == "some aperture"
      assert photo.description == "some description"
      assert photo.image == "some image"
      assert photo.iso == 42
      assert photo.lense == "some lense"
      assert photo.name == "some name"
      assert photo.shutterspeed == "some shutterspeed"
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Photos.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{} = photo} = Photos.update_photo(photo, @update_attrs)
      assert photo.aperture == "some updated aperture"
      assert photo.description == "some updated description"
      assert photo.image == "some updated image"
      assert photo.iso == 43
      assert photo.lense == "some updated lense"
      assert photo.name == "some updated name"
      assert photo.shutterspeed == "some updated shutterspeed"
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Photos.update_photo(photo, @invalid_attrs)
      assert photo == Photos.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end
end
