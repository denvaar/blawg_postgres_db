defmodule BlawgPostgresDb.MixProject do
  use Mix.Project

  def project do
    [
      app: :blawg_postgres_db,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        paths: [
          "_build/dev/lib/blawg_postgres_db/ebin",
          "_build/dev/lib/perseus/ebin"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BlawgPostgresDb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:perseus, path: "../perseus", app: false},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:dialyxir, "~> 0.5", only: [:dev]}
    ]
  end
end
