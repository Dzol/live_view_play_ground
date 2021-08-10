# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_view_play_ground,
  ecto_repos: [LiveViewPlayGround.Repo]

# Configures the endpoint
config :live_view_play_ground, LiveViewPlayGroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QcUMWJZZljwVNA4FIJC+QDetr6lBKF3NHCtSXfFo2dCigWgFJ52aDnQmE31+LCEa",
  render_errors: [view: LiveViewPlayGroundWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveViewPlayGround.PubSub,
  live_view: [signing_salt: "oGeuhPNM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
