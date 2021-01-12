defmodule CineminhaWeb.RoomController do
  use CineminhaWeb, :controller

  alias Cineminha.Rooms

  def create(conn, _params) do
    case Rooms.create_room() do
      {:ok, room} ->
        conn
        |> put_status(:ok)
        |> put_view(CineminhaWeb.RoomView)
        |> render("room.json", room: room)

      {:error, _message} ->
        conn
        |> put_view(CineminhaWeb.ErrorView)
        |> render("500.json")
    end
  end
end
