defmodule BlawgPostgresDb do
  defdelegate create_article(params), to: BlawgPostgresDb.Articles
  defdelegate update_article(slug, params), to: BlawgPostgresDb.Articles
  defdelegate get_article(slug), to: BlawgPostgresDb.Articles
  defdelegate list_articles(), to: BlawgPostgresDb.Articles
  defdelegate delete_article(slug_or_id), to: BlawgPostgresDb.Articles
end
