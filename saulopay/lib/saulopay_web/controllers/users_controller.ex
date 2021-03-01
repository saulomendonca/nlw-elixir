defmodule SaulopayWeb.UsersController do
  use SaulopayWeb, :controller

  alias Saulopay.User

  action_fallback SaulopayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Saulopay.create_user(params) do
      conn
    |> put_status(:created)
    |> render("create.json", user: user)
    end
  end
end
