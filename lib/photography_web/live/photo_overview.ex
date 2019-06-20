defmodule PhotographyWeb.PhotoOverview do
  use Phoenix.LiveView

  alias PhotographyWeb.PhotoView

  alias Photography.Photos

  def render(assigns) do
    PhotoView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    photos = Photos.list_photos_reverse()
    categories = get_categories(photos)
    {
      :ok,
      assign(socket,
        all_photos: photos,
        filtered_photos: photos,
        category: "all",
        query: "",
        categories: categories,
        menu_open: "false")
    }
  end

  defp get_categories(photos) do
    photos
    |> Enum.reduce(MapSet.new(), fn x, acc -> MapSet.put(acc, String.downcase(x.category))  end)
    |>MapSet.to_list()
  end

  defp assign_filtered(socket, category, query) do

    filtered =
      socket.assigns.all_photos
      |> filter_category(category)
      |> filter_query(query)

    assign(
      socket,
      filtered_photos: filtered,
      query: query,
      category: category,
      menu_open: "false"
    )
  end

  defp filter_category(photos, category) do
    case category do
      "all" ->
        photos
      _ ->
        photos
        |> Enum.filter(
             fn p ->
               if String.match?(p.category, ~r/#{category}/i) do
                 true
               end
             end
           )
    end
  end

  defp filter_query(photos, query) do
    photos
    |> Enum.filter(&String.match?(&1.name, ~r/#{query}/i))
  end

  def handle_event("search", %{"query" => query}, socket) do
    {:noreply, assign_filtered(socket, socket.assigns.category, query)}
  end

  def handle_event("filter-category", category, socket) do
    {:noreply, assign_filtered(socket, category, socket.assigns.query)}
  end

  def handle_event("toggle-menu", should_open, socket) do
    {:noreply, assign(socket, menu_open: should_open)}
  end

end