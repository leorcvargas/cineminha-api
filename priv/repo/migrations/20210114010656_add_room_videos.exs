defmodule Cineminha.Repo.Migrations.AddVideos do
  use Ecto.Migration

  def up do
    create table(:room_videos) do
      add :url, :string, null: false
      add :room_id, references(:rooms), null: false

      timestamps()
    end
  end

  def down do
    drop table(:room_videos)
  end
end
