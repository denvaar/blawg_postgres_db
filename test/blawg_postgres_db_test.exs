defmodule BlawgPostgresDbTest do
  use ExUnit.Case
  use BlawgPostgresDb.RepoCase
  doctest BlawgPostgresDb

  test "perform CRUD operations for articles" do
    # This test does too much, but it's OK for now

    assert BlawgPostgresDb.list_articles() == []

    data = %{title: "Test Title", content: "Blaw blaw blaw..."}
    {:ok, %{slug: slug}} = BlawgPostgresDb.create_article(data)

    BlawgPostgresDb.update_article(slug, %{content: "New content..."})
    article = BlawgPostgresDb.get_article(slug)

    assert article.content == "New content..."

    assert BlawgPostgresDb.list_articles() == [article]

    BlawgPostgresDb.delete_article(slug)

    assert BlawgPostgresDb.list_articles() == []
  end
end
