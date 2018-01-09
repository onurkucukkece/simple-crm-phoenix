defmodule DandWeb.AuthController do
  use DandWeb, :controller

  alias Dand.Accounts
  alias Dand.Accounts.User
  alias Dand.Accounts.Guardian
  alias OauthAzureActivedirectory.Client

  def request(conn, _params) do
    redirect conn, external: Client.authorize_url!(_params)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
    # render(conn, "request.html", callback_url: Helpers.callback_url(conn, [response_type: "code id_token",
    # response_mode: "form_post"]))
  end

  def callback(conn, _params) do
  # def callback(%{assigns: %{azuread_auth: auth}} = conn, _params) do
    {:ok, jwt} = Client.process_callback!(conn)
    case Accounts.find_or_create_user(jwt) do
      {:ok, user} ->
        conn
        |> put_flash(:success, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
