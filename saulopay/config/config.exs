# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :saulopay,
  ecto_repos: [Saulopay.Repo]

# Configures the endpoint
config :saulopay, SaulopayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y8jJgj3Qamvs5MrgTyM0Cd0Li4Rf5Hy0tVgAs/K+MbEh/8qz2r2K5vhmMP8vjAGs",
  render_errors: [view: SaulopayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Saulopay.PubSub,
  live_view: [signing_salt: "kOtL3u0+"]

config :saulopay, Saulopay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
