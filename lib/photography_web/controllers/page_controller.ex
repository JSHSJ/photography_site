defmodule PhotographyWeb.PageController do
  use PhotographyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def impressum(conn, _params) do
    render(conn, "impressum.html")
  end

  def datenschutz(conn, _params) do
    render(conn, "datenschutz.html")
  end
end
