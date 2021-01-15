defmodule Cineminha.RoomVideos do
  @moduledoc """
  The Videos context.
  """
  import Ecto
  import Ecto.Query, warn: false
  import GoogleApi.YouTube.V3.Api.Search

  alias Cineminha.Repo
  alias Cineminha.Rooms.Room
  alias Cineminha.Rooms.RoomVideo

  def search_on_youtube(query) do
    conn = GoogleApi.YouTube.V3.Connection.new()

    result =
      youtube_search_list(
        conn,
        ["snippet"],
        q: query,
        key: System.get_env("GOOGLE_API_KEY")
      )

    result
  end

  def create_room_video(room_slug, attrs \\ %{}) do
    changeset =
      Repo.get_by!(Room, slug: room_slug)
      |> build_assoc(:room_videos)
      |> RoomVideo.changeset(attrs)

    Repo.insert(changeset)
  end

  def list_videos_by_room_slug(room_slug) do
    query = from rv in RoomVideo,
            join: r in Room, on: r.id == rv.room_id,
            where: r.slug == ^room_slug,
            order_by: [desc: rv.inserted_at]

    Repo.all(query)
  end
end
