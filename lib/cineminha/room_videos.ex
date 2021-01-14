defmodule Cineminha.RoomVideos do
  @moduledoc """
  The Videos context.
  """

  import GoogleApi.YouTube.V3.Api.Search

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
end
