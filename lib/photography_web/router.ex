defmodule PhotographyWeb.Router do
  use PhotographyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhotographyWeb.Auth

  end

  pipeline :backend_layout do
    plug :put_layout, {PhotographyWeb.LayoutView, :backend}
  end

#  pipeline :api do
#    plug :accepts, ["json"]
#  end


  scope "/", PhotographyWeb do
    pipe_through :browser

    get "/", PhotoController, :index
    get "/:photo_slug", PhotoController, :show
  end

  scope "/admin", PhotographyWeb.Admin, as: :admin do
    pipe_through [:browser, :backend_layout]

    get "/login", AdminController, :login
    post "/logged-in", AdminController, :logged_in
    delete "/logout", AdminController, :logout

    resources "/photos", PhotoController
    get "/photos/:id/edit-picture", PhotoController, :edit_picture

  end

  # Other scopes may use custom stacks.
  # scope "/api", PhotographyWeb do
  #   pipe_through :api
  # end
end
