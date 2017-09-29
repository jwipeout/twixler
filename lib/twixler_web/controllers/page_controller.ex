defmodule TwixlerWeb.PageController do
  use TwixlerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
