defmodule PhotographyWeb.PhotoController do
  use PhotographyWeb, :controller

  alias Photography.Photos
  alias Photography.Photos.Photo

  alias Phoenix.LiveView

  plug :put_layout, "photo.html"


  def index(conn, _params) do
    LiveView.Controller.live_render(conn, PhotographyWeb.PhotoOverview,
      session: %{}
    )
  end


  def show(conn, %{"photo_slug" => slug}) do
    photo = Photos.get_photo!(slug: slug)
    render(conn, "show.html", photo: photo)
  end
end
