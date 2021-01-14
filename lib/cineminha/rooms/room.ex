defmodule Cineminha.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :expires_at, :naive_datetime
    field :slug, :string
    has_many :videos, Cineminha.Rooms.Video

    timestamps()
  end

  @doc false
  def changeset(room, attrs \\ %{}) do
    room
    |> cast(attrs, [:slug, :expires_at])
    |> validate_required([:slug, :expires_at])
  end
end
