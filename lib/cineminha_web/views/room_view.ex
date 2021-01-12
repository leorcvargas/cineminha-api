defmodule CineminhaWeb.RoomView do
  use CineminhaWeb, :view

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      slug: room.slug,
      expires_at: room.expires_at,
    }
  end

  def render("show.json", %{room: room}) do
    render_one(room, CineminhaWeb.RoomView, "room.json")
  end
end
