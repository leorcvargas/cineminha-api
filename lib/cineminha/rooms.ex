defmodule Cineminha.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Cineminha.Repo
  alias Cineminha.Rooms.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  def get_room_by_slug(slug), do: Repo.get_by(Room, slug: slug)

  def get_room_and_videos_by_slug(room_slug) do
    Room
    |> Repo.get_by(slug: room_slug)
    |> Repo.preload(:room_videos)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room()
      {:ok, %Room{}}

      iex> create_room()
      {:error, %Ecto.Changeset{}}

  """
  def create_room() do
    current_date = NaiveDateTime.utc_now()
    tomorrow_date = NaiveDateTime.add(current_date, 86400, :second)

    attrs = %{
      slug: generate_random_slug(15),
      expires_at: tomorrow_date
    }

    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  defp generate_random_slug(count) do
    :crypto.strong_rand_bytes(count)
    |> Base.url_encode64(padding: false)
    |> binary_part(0, count)
  end
end
