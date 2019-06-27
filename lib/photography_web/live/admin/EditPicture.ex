defmodule PhotographyWeb.Admin.EditPicture do

  alias PhotographyWeb.Admin.PhotoView
  use Phoenix.LiveView

  import Mogrify



  def mount(session, socket) do
    {
    :ok, assign(socket, %{photo: session.photo, rotation: 0})
    }
  end

  def render(assigns) do
    PhotoView.render("edit_picture.html", assigns)
  end

  def handle_event("rotate", amount, socket) do
    dirname = "photos/media/photos/" <> socket.assigns.photo.uuid
    IO.inspect(dirname)
    files = Path.wildcard("#{dirname}/*.{jpg,JPG,png,PNG,jpeg,JPEG,webp,WEBP}")

    files
    |> Enum.each(fn file ->
      file
      |> open
      |> custom("rotate", amount)
      |> save(in_place: true)
    end)


    {rotation_amount, _ }  = Integer.parse(amount)
    rotation = socket.assigns.rotation + rotation_amount

    new_rotation = cond do
      rotation < 0 ->  270
      rotation > 270 -> 0
      true -> rotation
    end
    {:noreply,
      assign(socket, %{rotation: new_rotation})
    }
  end

end
