defmodule Saulopay.Repo do
  use Ecto.Repo,
    otp_app: :saulopay,
    adapter: Ecto.Adapters.Postgres
end
