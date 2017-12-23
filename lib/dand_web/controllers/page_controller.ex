defmodule DandWeb.PageController do
  use DandWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
