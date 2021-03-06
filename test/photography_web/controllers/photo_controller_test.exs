defmodule PhotographyWeb.PhotoControllerTest do
  use PhotographyWeb.ConnCase

  alias Photography.Photos

  @create_attrs %{aperture: "some aperture", description: "some description", image: "some image", iso: 42, lense: "some lense", name: "some name", shutterspeed: "some shutterspeed"}
  @update_attrs %{aperture: "some updated aperture", description: "some updated description", image: "some updated image", iso: 43, lense: "some updated lense", name: "some updated name", shutterspeed: "some updated shutterspeed"}
  @invalid_attrs %{aperture: nil, description: nil, image: nil, iso: nil, lense: nil, name: nil, shutterspeed: nil}

  def fixture(:photo) do
    {:ok, photo} = Photos.create_photo(@create_attrs)
    photo
  end

  describe "index" do
    test "lists all photos", %{conn: conn} do
      conn = get(conn, Routes.photo_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Photos"
    end
  end

  describe "new photo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.photo_path(conn, :new))
      assert html_response(conn, 200) =~ "New Photo"
    end
  end

  describe "create photo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.photo_path(conn, :create), photo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.photo_path(conn, :show, id)

      conn = get(conn, Routes.photo_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Photo"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.photo_path(conn, :create), photo: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Photo"
    end
  end

  describe "edit photo" do
    setup [:create_photo]

    test "renders form for editing chosen photo", %{conn: conn, photo: photo} do
      conn = get(conn, Routes.photo_path(conn, :edit, photo))
      assert html_response(conn, 200) =~ "Edit Photo"
    end
  end

  describe "update photo" do
    setup [:create_photo]

    test "redirects when data is valid", %{conn: conn, photo: photo} do
      conn = put(conn, Routes.photo_path(conn, :update, photo), photo: @update_attrs)
      assert redirected_to(conn) == Routes.photo_path(conn, :show, photo)

      conn = get(conn, Routes.photo_path(conn, :show, photo))
      assert html_response(conn, 200) =~ "some updated aperture"
    end

    test "renders errors when data is invalid", %{conn: conn, photo: photo} do
      conn = put(conn, Routes.photo_path(conn, :update, photo), photo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Photo"
    end
  end

  describe "delete photo" do
    setup [:create_photo]

    test "deletes chosen photo", %{conn: conn, photo: photo} do
      conn = delete(conn, Routes.photo_path(conn, :delete, photo))
      assert redirected_to(conn) == Routes.photo_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.photo_path(conn, :show, photo))
      end
    end
  end

  defp create_photo(_) do
    photo = fixture(:photo)
    {:ok, photo: photo}
  end
end
