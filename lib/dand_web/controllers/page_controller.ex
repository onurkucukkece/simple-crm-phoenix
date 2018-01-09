defmodule DandWeb.PageController do
  use DandWeb, :controller

	alias Dand.Accounts
  alias Dand.Accounts.User
  alias Dand.Accounts.Guardian
  alias DandWeb.Router.Helpers

  import DandWeb.Router.Helpers
  def index(conn, _params) do
    changeset = Accounts.change_user(%User{})
    current_user = Guardian.Plug.current_resource(conn)
    
    if current_user != nil do
      conn
      |> redirect(to: page_path(conn, :login))
    else
      conn
      |> render("index.html", changeset: changeset, action: page_path(conn, :login), current_user: current_user)
    end
  end

  def login(conn, params) do
    changeset = Accounts.change_user(%User{})
    conn |> render("login.html", changeset: changeset)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: page_path(conn, :login))
  end

  def secret(conn, _params) do
    render(conn, "secret.html")
  end
end
