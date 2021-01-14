defmodule CineminhaWeb.RoomChannel do
  use CineminhaWeb, :channel

  alias Cineminha.Rooms
  alias CineminhaWeb.Presence

  def join("room:" <> room_slug, _payload, socket) do
    room = Rooms.get_room_by_slug(room_slug)

    send(self(), :after_join)

    response = CineminhaWeb.RoomView.render("room.json", room: room)

    {:ok, response, assign(socket, :room, room)}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))

    {:noreply, socket}
  end

  def handle_in("room:video:change:url", %{"url" => url}, socket) do
    room_slug = socket.assigns.room.slug

    updated_socket = assign(socket, :current_video_url, url)

    broadcast!(updated_socket, "room:#{room_slug}:video:change:url", %{url: url})

    {:reply, :ok, updated_socket}
  end

  def handle_in("room:video:change:time", %{"time" => time}, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:change:time", %{time: time})

    {:reply, :ok, socket}
  end

  def handle_in("room:video:play", %{"time" => time}, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:play", %{time: time})

    {:reply, :ok, socket}
  end

  def handle_in("room:video:pause", %{"time" => time}, socket) do
    room_slug = socket.assigns.room.slug

    broadcast!(socket, "room:#{room_slug}:video:pause", %{time: time})

    {:reply, :ok, socket}
  end
end
