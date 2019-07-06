defmodule BlawgPostgresDbTest do
  use ExUnit.Case
  use BlawgPostgresDb.RepoCase
  doctest BlawgPostgresDb

  test "create an article" do
    data = %{title: "Test Title", content: "Blaw blaw blaw..."}
    assert BlawgPostgresDb.create_article(data) == {:ok, %{slug: "test-title"}}
  end
end
