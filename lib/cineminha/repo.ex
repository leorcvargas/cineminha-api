defmodule Cineminha.Repo do
  use Ecto.Repo,
    otp_app: :cineminha,
    adapter: Ecto.Adapters.Postgres
end
