defmodule Dand.Accounts.ErrorHandler do
	import Plug.Conn
  	
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(_reason)
    conn
	  	|> Phoenix.Controller.redirect(to: "/login", method: "get")
	  	|> halt
  end
end