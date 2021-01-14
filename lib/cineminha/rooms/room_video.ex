defmodule Cineminha.Rooms.RoomVideo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "room_videos" do
    field :url, :string
    belongs_to :room, Cineminha.Rooms.Room

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :room_id])
    |> validate_required([:url, :room_id])
  end
end
