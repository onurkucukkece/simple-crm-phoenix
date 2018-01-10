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
    plug :put_secure_browser_headers
  end

  pipeline :forgery_protect do
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Maybe logged in scope
  scope "/", DandWeb do
    pipe_through [:browser, :auth, :forgery_protect]
    
    get "/login", PageController, :login
    # post "/", PageController, :login
    post "/logout", PageController, :logout
  end

  scope "/auth", DandWeb do
    pipe_through :browser

    post "/:provider/callback", AuthController, :callback
  end

  scope "/auth", DandWeb do
    pipe_through [:browser]
    
    get "/:provider", AuthController, :request
  end

  # Definitely logged in scope
  scope "/", DandWeb do
    pipe_through [:browser, :auth, :ensure_auth, :forgery_protect]
    get "/secret", PageController, :secret

    get "/", PageController, :index
    resources "/users", UserController
    resources "/tickets", TicketController
  end  

  # Other scopes may use custom stacks.
  # scope "/api", DandWeb do
  #   pipe_through :api
  # end
end
