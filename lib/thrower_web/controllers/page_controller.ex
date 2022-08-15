defmodule ThrowerWeb.PageController do
  use ThrowerWeb, :controller

  def index(conn, _params) do
    json(conn, "hello")
  end
end
