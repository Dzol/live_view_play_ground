defmodule LiveViewPlayGround.Repo do
  use Ecto.Repo,
    otp_app: :live_view_play_ground,
    adapter: Ecto.Adapters.Postgres
end
