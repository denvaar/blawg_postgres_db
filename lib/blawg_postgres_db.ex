defmodule BlawgPostgresDb do
  @behaviour Perseus.Article

  alias BlawgPostgresDb.{Article, Repo}

  @impl Perseus.Article
  def create_article(params) do
    changeset = build_article_changeset(params)

    case Repo.insert(changeset) do
      {:ok, changeset} ->
        {:ok, %{slug: changeset.slug}}
      {:error, changeset} ->
        {:error, humanize_errors(changeset)}
    end
  end

  @impl Perseus.Article
  def update_article(slug, params) do
    article = Repo.get_by(Article, slug: slug)

    if article !== nil do
      changeset = build_article_changeset(article, params)

      case Repo.update(changeset) do
        {:ok, changeset} ->
          {:ok, normalize_article(changeset)}
        {:error, changeset} ->
          {:error, humanize_errors(changeset)}
      end
    else
      :not_found
    end
  end

  @impl Perseus.Article
  def get_article(slug) do
    article = Repo.get_by(Article, slug: slug)

    if article do
      normalize_article(article)
    end
  end

  @impl Perseus.Article
  def list_articles() do
    Repo.all(Article)
    |> Enum.map(fn article ->
      normalize_article(article)
    end)
  end

  @impl Perseus.Article
  def delete_article(slug) when is_binary(slug) do
    article = Repo.get_by(Article, slug: slug)

    if article !== nil do
      case Repo.delete(article) do
        {:ok, _article} -> :ok
        {:error, _changeset} -> :not_found
      end
    else
        :not_found
    end
  end

  @impl Perseus.Article
  def delete_article(id) do
    article = Repo.get(Article, id)

    if article !== nil do
      case Repo.delete(article) do
        {:ok, _article} -> :ok
        {:error, _changeset} -> :not_found
      end
    else
        :not_found
    end
  end



  defp build_article_changeset(params) do
    %Article{}
    |> Article.changeset(params)
  end

  defp build_article_changeset(article, params) do
    article
    |> Article.changeset(params)
  end

  defp humanize_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  defp normalize_article(article) do
    %Perseus.Article.Article{id: article.id,
      slug: article.slug,
      title: article.title,
      content: article.content,
      date_published: article.date_published}
  end
end
