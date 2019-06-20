defmodule Photography.Repo do
  use Ecto.Repo,
    otp_app: :photography,
    adapter: Ecto.Adapters.Postgres
end
