defmodule Cineminha.Repo.Migrations.AddVideos do
  use Ecto.Migration

  def up do
    create table(:videos) do
      add :url, :string, null: false
      add :room_id, references(:rooms), null: false

      timestamps()
    end
  end

  def down do
    drop table(:videos)
  end
end
