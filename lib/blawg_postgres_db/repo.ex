defmodule BlawgPostgresDb.Repo do
  use Ecto.Repo,
    otp_app: :blawg_postgres_db,
    adapter: Ecto.Adapters.Postgres
end
