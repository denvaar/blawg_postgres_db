defmodule BlawgPostgresDbTest do
  use ExUnit.Case
  doctest BlawgPostgresDb

  test "create an article" do
    data = %{title: "Test Title", content: "Blaw blaw blaw..."}

    assert BlawgPostgresDb.create_article(data) == {:ok, %{id: id}}
  end

  test "update an article" do
    data = %{}
    id = 1
    assert BlawgPostgresDb.update_article(id, data) == {:ok, %{id: id}}
  end
end
