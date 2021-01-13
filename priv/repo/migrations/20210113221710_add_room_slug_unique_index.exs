defmodule Cineminha.Repo.Migrations.AddRoomSlugUniqueIndex do
  use Ecto.Migration

  def up do
    create unique_index("rooms", :slug)
  end

  def down do
    drop unique_index("rooms", :slug)
  end
end
