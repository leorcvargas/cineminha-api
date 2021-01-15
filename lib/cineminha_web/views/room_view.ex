defmodule CineminhaWeb.RoomView do
  use CineminhaWeb, :view

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      slug: room.slug,
      room_videos:
        case room.room_videos do
          %Ecto.Association.NotLoaded{} -> []
          _ -> CineminhaWeb.RoomVideoView.render("index.json", room_videos: room.room_videos)
        end,
      expires_at: room.expires_at
    }
  end

  def render("show.json", %{room: room}) do
    render_one(room, CineminhaWeb.RoomView, "room.json")
  end
end
