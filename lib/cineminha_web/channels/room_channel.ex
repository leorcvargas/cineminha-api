defmodule CineminhaWeb.RoomChannel do
  use CineminhaWeb, :channel

  alias Cineminha.Rooms

  def join("room:" <> room_slug, _payload, socket) do
    room = Rooms.get_room_by_slug(room_slug)

    response = CineminhaWeb.RoomView.render("room.json", room: room)

    {:ok, response, assign(socket, :room, room)}
  end

  def handle_in("room:video:change:url", %{"url" => url}, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:change", %{url: url})
    {:reply, :ok, socket}
  end

  def handle_in("room:video:change:time", %{"time" => time}, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:change:time", %{time: time})
    {:reply, :ok, socket}
  end

  def handle_in("room:video:play", _payload, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:play", %{})
    {:reply, :ok, socket}
  end

  def handle_in("room:video:pause", _payload, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:pause", %{})
    {:reply, :ok, socket}
  end
end
