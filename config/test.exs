use Mix.Config

config :blawg_postgres_db, BlawgPostgresDb.Repo,
  username: "postgres",
  password: "",
  database: "blawg_postgres_db_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
