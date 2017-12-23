# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dand,
  ecto_repos: [Dand.Repo]

# Configures the endpoint
config :dand, DandWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UTc2sTKgIevFXyLIACl1LJMcqprkHu2KQbn5Er5NDWFCfj37Fu7p5gtnlIame2Zr",
  render_errors: [view: DandWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dand.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Slim configuraiton
config :phoenix, :template_engines,
    slim: PhoenixSlime.Engine,
   slime: PhoenixSlime.Engine

config :phoenix_slime, :use_slim_extension, true

# Guardian configuration
# config :guardian, Guardian,
#   allowed_algos: ["HS512"],
#   verify_module: Guardian.JWT,
#   issuer: DandWeb,
#   ttl: { 30, :days},
#   verify_issuer: true,
#   secret_key: "DASDASdasdasd",
#   serializer: DandWeb.GuardianSerializer