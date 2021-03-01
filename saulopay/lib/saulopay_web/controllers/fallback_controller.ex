defmodule SaulopayWeb.FallbackController do
  use SaulopayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(SaulopayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
