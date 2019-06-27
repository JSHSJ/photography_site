defmodule PhotographyWeb.Admin.AdminController do
  use PhotographyWeb, :controller

  plug :authenticate when action in [:index, :logout]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, _params) do
    if conn.assigns.current_user do
      conn
      |> redirect(to: Routes.admin_admin_path(conn, :index))
    end

    render(conn, "login.html")
  end

  def logged_in(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case PhotographyWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.photo_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("login.html")
    end
  end

  def logout(conn, _) do
    conn
    |> PhotographyWeb.Auth.logout()
    |> redirect(to: Routes.photo_path(conn, :index))
  end

  def products(conn, _) do
    render(conn, "products.html")
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.photo_path(conn, :index))
      |> halt()
    end
  end
end
