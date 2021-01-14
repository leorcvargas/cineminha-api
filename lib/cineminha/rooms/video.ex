defmodule Cineminha.Rooms.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    belongs_to :room, Cineminha.Rooms.Room

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [])
    |> validate_required([])
  end
end
