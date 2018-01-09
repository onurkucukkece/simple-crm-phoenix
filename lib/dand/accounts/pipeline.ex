defmodule Dand.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :dand,
    error_handler: Dand.Accounts.ErrorHandler,
    module: Dand.Accounts.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Guardian.Plug.EnsureAuthenticated
end