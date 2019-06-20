# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :photography,
  ecto_repos: [Photography.Repo]

# Configures the endpoint
config :photography, PhotographyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FsgeQvVgOul5M80Jea8e22k7xWliCbrRJrWeK9upbAlhYXzpzYGPLs/Tpd54j9Tm",
  render_errors: [view: PhotographyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Photography.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "twpx2aqpbm+SznJYhauApCdpxMa1BG8O"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Arc config
config :arc,
  storage: Arc.Storage.Local



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
