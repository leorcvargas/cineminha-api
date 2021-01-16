defmodule CineminhaWeb.RoomVideoController do
  use CineminhaWeb, :controller

  alias Cineminha.RoomVideos

  def search_on_youtube(conn, %{"q" => q}) do
    case RoomVideos.search_on_youtube(q) do
      {:ok, result} ->
        IO.inspect(result.items)

        conn
        |> put_status(:ok)
        |> put_view(CineminhaWeb.RoomVideoYTView)
        |> render("index.json", items: result.items)

      {:error, _reason} ->
        conn
        |> put_view(CineminhaWeb.ErrorView)
        |> put_status(:internal_server_error)
        |> render("500.json")
    end
  end
end
