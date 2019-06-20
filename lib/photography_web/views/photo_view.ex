defmodule PhotographyWeb.PhotoView do
  use PhotographyWeb, :view

  def column_1(photos) do
    photos
    |> Enum.take_every(3)
  end

  def column_2(photos) do
    photos
    |> Enum.drop(1)
    |> Enum.take_every(3)
  end

  def column_3(photos) do
    photos
    |> Enum.drop(2)
    |> Enum.take_every(3)
  end
end
