# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :blawg_postgres_db,
  ecto_repos: [BlawgPostgresDb.Repo]

import_config "#{Mix.env()}.exs"
