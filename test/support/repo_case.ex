defmodule BlawgPostgresDb.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias BlawgPostgresDb.Repo

      import Ecto
      import Ecto.Query
      import BlawgPostgresDb.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BlawgPostgresDb.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(BlawgPostgresDb.Repo, {:shared, self()})
    end

    :ok
  end
end
