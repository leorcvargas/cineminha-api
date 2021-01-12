defmodule Cineminha.RoomsTest do
  use Cineminha.DataCase

  alias Cineminha.Rooms

  describe "rooms" do
    alias Cineminha.Rooms.Room

    @valid_attrs %{expires_at: ~N[2010-04-17 14:00:00], slug: "some slug"}
    @update_attrs %{expires_at: ~N[2011-05-18 15:01:01], slug: "some updated slug"}
    @invalid_attrs %{expires_at: nil, slug: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Rooms.create_room(@valid_attrs)
      assert room.expires_at == ~N[2010-04-17 14:00:00]
      assert room.slug == "some slug"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Rooms.update_room(room, @update_attrs)
      assert room.expires_at == ~N[2011-05-18 15:01:01]
      assert room.slug == "some updated slug"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end
end
