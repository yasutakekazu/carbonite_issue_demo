defmodule CarboniteIssueDemo.NotesTest do
  use CarboniteIssueDemo.DataCase

  alias CarboniteIssueDemo.Notes

  describe "notes" do
    alias CarboniteIssueDemo.Notes.Note

    import CarboniteIssueDemo.NotesFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notes.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notes.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %Note{} = note} = Notes.create_note(valid_attrs)
      assert note.title == "some title"
      assert note.body == "some body"

      meta =
        Carbonite.Query.current_transaction()
        |> CarboniteIssueDemo.Repo.one!()
        |> Map.fetch!(:meta)

      assert ^meta = %{"type" => "note_created"}
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = with_ignored_carbonite(fn -> note_fixture() end)
      update_attrs = %{title: "some updated title", body: "some updated body"}
      assert {:ok, %Note{} = note} = Notes.update_note(note, update_attrs)
      assert note.title == "some updated title"
      assert note.body == "some updated body"

      Carbonite.Query.transactions(preload: true)
      |> CarboniteIssueDemo.Repo.all()
      |> dbg()

      meta =
        Carbonite.Query.current_transaction()
        |> CarboniteIssueDemo.Repo.one!()
        |> Map.fetch!(:meta)

      # This assertion fails because the meta type is "note_created"
      assert ^meta = %{"type" => "note_updated"}
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
      assert note == Notes.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notes.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notes.change_note(note)
    end
  end

  def with_ignored_carbonite(fun) do
    Carbonite.override_mode(CarboniteIssueDemo.Repo, to: :ignore)
    result = fun.()
    Carbonite.override_mode(CarboniteIssueDemo.Repo, to: :capture)
    result
  end
end
