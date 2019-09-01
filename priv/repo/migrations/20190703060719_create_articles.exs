defmodule BlawgPostgresDb.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :content, :text
      add :date_published, :utc_datetime
      add :slug, :string
      add :title, :string

      timestamps()
    end

    create index(:articles, [:slug], unique: true)
  end
end
