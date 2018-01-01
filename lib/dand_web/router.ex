defmodule DandWeb.Router do
  use DandWeb, :router

  pipeline :auth do
    plug Dand.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end
 
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Maybe logged in scope
  scope "/", DandWeb do
    pipe_through [:browser, :auth]
    get "/", PageController, :index
    post "/", PageController, :login
    post "/logout", PageController, :logout
  end

  scope "/auth", DandWeb do
    pipe_through :browser
    
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Definitely logged in scope
  scope "/", DandWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/secret", PageController, :secret

    resources "/users", UserController
    resources "/tickets", TicketController
  end  

  # Other scopes may use custom stacks.
  # scope "/api", DandWeb do
  #   pipe_through :api
  # end
end
