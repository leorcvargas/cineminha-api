defmodule CineminhaWeb.RoomVideoYTView do
  use CineminhaWeb, :view

  def render("room_video_yt.json", %{room_video_yt: room_video_yt}) do
    %{
      id: room_video_yt.id.videoId,
      url: "https://www.youtube.com/watch?v=#{room_video_yt.id.videoId}",
      thumbnail_url: room_video_yt.snippet.thumbnails.medium.url,
      title: room_video_yt.snippet.title,
      channel_name: room_video_yt.snippet.channelTitle
    }
  end

  def render("show.json", %{room_video_yt: room_video_yt}) do
    render_one(room_video_yt, CineminhaWeb.RoomVideoYTView, "room_video_yt.json")
  end

  def render("index.json", %{items: items}) do
    IO.puts("========================================================")
    render_many(items, CineminhaWeb.RoomVideoYTView, "room_video_yt.json")
  end
end
