use Mix.Config

config :blawg_postgres_db, BlawgPostgresDb.Repo,
  database: "blawg_postgres_db_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
