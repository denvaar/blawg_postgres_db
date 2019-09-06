defmodule BlawgPostgresDb.Article do
  use Ecto.Schema

  schema "articles" do
    field(:content, :string)
    field(:date_published, :utc_datetime)
    field(:slug, :string)
    field(:title, :string)
    field(:summary, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    params = if struct.slug === nil, do: Map.merge(params, slugify(params)), else: params

    struct
    |> Ecto.Changeset.cast(params, [:title, :slug, :content, :summary, :date_published])
    |> Ecto.Changeset.validate_required([:title, :content, :summary])
    |> Ecto.Changeset.unique_constraint(:slug)
  end

  defp slugify(%{"title" => title}) do
    %{"slug" => do_the_slug_stuff(title)}
  end

  defp slugify(%{title: title}) do
    %{slug: do_the_slug_stuff(title)}
  end

  defp slugify(_params) do
    %{}
  end

  defp do_the_slug_stuff(title) do
    title
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
