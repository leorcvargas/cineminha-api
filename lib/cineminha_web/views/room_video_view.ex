defmodule CineminhaWeb.RoomVideoView do
  use CineminhaWeb, :view

  def render("room_video.json", %{room_video: room_video}) do
    %{
      id: room_video.id,
      url: room_video.url,
      room_id: room_video.room_id,
      inserted_at: room_video.inserted_at,
    }
  end

  def render("room_video_yt_result.json", %{item: item}) do
    %{
      id: item.id.videoId
    }
  end

  def render("show.json", %{room_video: room_video}) do
    render_one(room_video, CineminhaWeb.RoomVideoView, "room_video.json")
  end

  def render("index.json", %{room_videos: room_videos}) do
    render_many(room_videos, CineminhaWeb.RoomVideoView, "room_video.json")
  end

  def render("index_yt_result.json", %{items: items}) do
    render_many(items, CineminhaWeb.RoomVideoView, "room_video_yt_result.json")
  end
end
