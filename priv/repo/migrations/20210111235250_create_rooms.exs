defmodule Cineminha.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :slug, :string
      add :expires_at, :naive_datetime

      timestamps()
    end

  end
end
