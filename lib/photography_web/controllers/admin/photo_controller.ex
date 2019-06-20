defmodule PhotographyWeb.Admin.PhotoController do
  use PhotographyWeb, :controller

  alias Photography.Photos
  alias Photography.Photos.Photo
  alias Photography.Image

  alias Phoenix.LiveView


  plug :authenticate

  def index(conn, _params) do
    photos = Photos.list_photos_reverse()
    conn
    |> render("index.html", photos: photos)
  end

  def new(conn, _params) do
    changeset = Photos.change_photo(%Photo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"photo" => photo_params}) do
    case Photos.create_photo(photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo created successfully.")
        |> redirect(to: Routes.admin_photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => slug}) do
    photo = Photos.get_photo!(slug: slug)
    render(conn, "show.html", photo: photo)
  end

  def edit(conn, %{"id" => slug}) do
    photo = Photos.get_photo!(slug: slug)
    changeset = Photos.change_photo(photo)
    render(conn, "edit.html", photo: photo, changeset: changeset)
  end

  def update(conn, %{"id" => slug, "photo" => photo_params}) do
    photo = Photos.get_photo!(slug: slug)

    case Photos.update_photo(photo, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo updated successfully.")
        |> redirect(to: Routes.admin_photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", photo: photo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => slug}) do
    photo = Photos.get_photo!(slug: slug)
    :ok = Image.delete({photo.image, photo})
    {:ok, _photo} = Photos.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.admin_photo_path(conn, :index))
  end

  def edit_picture(conn, %{"id" => slug}) do
    photo = Photos.get_photo!(slug: slug)
    LiveView.Controller.live_render(conn, PhotographyWeb.Admin.EditPicture, session: %{photo: photo})
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
