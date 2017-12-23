defmodule DandWeb.Router do
  use DandWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: DandWeb.Token
    plug Guardian.Plug.LoadResource
  end
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DandWeb do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    resources "/tickets", TicketController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DandWeb do
  #   pipe_through :api
  # end
end
