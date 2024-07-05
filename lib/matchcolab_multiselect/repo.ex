defmodule MatchcolabMultiselect.Repo do
  use Ecto.Repo,
    otp_app: :matchcolab_multiselect,
    adapter: Ecto.Adapters.Postgres
end
