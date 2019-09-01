defmodule BlawgPostgresDb.MixProject do
  use Mix.Project

  def project do
    [
      name: "Blawg PostgreSQL Database",
      docs: [main: "BlawgPostgresDb"],
      source_url: "https://github.com/denvaar/blawg_postgres_db",
      app: :blawg_postgres_db,
      version: "0.1.0",
      elixir: "~> 1.9.1",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        # plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        flags: [:unmatched_returns, :error_handling, :race_conditions, :underspecs],
        paths: [
          "_build/dev/lib/blawg_postgres_db/ebin",
          "_build/dev/lib/perseus/ebin"
        ]
      ],
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
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
      {:perseus, git: "https://github.com/denvaar/perseus.git", app: false},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:ex_doc, "~>  0.21.2", only: [:dev], runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
