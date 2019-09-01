alias BlawgPostgresDb.Article
alias BlawgPostgresDb.Repo

titles =
  File.read!("/Users/denvaar/projects/text/titles.csv")
  |> String.trim()
  |> String.split("\n")

slugs =
  titles
  |> Enum.map(fn title ->
    title
    |> String.replace(" ", "-")
    |> String.downcase()
  end)

summaries =
  File.read!("/Users/denvaar/projects/text/summary.csv")
  |> String.trim()
  |> String.split("\n")

dates =
  File.read!("/Users/denvaar/projects/text/date_published.csv")
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn date_string ->
    {:ok, date, _} = date_string <> " 00:00:00+0000"
      |> DateTime.from_iso8601()
    date
  end)

bodies =
  File.read!("/Users/denvaar/projects/text/body.csv")
  |> String.trim()
  |> String.split("---split---")

{:ok, _result} =
  [titles, slugs, summaries, dates, bodies]
  |> Enum.zip()
  |> Enum.map(fn {title, slug, summary, date, body} ->
    %Article{}
    |> Article.changeset(
      %{title: title,
        summary: summary,
        slug: slug,
        date_published: date,
        content: body})
  end)
  |> Enum.with_index()
  |> Enum.reduce(Ecto.Multi.new(), fn({changeset, index}, multi) ->
    Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
  end)
  |> Repo.transaction()
