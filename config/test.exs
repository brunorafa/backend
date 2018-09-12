use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :re, ReWeb.Endpoint,
  http: [port: 4001],
  server: false,
  env: "test"

# Print only warnings and errors during test
config :logger, level: :warn

config :re, ReWeb.Guardian,
  allowed_algos: ["ES512"],
  secret_key: %{
    "alg" => "ES512",
    "crv" => "P-521",
    "d" =>
      "W9YqJjm9e452o7dPksq6vBZepwd8a4jZFW_t-UIDMUF06kd1dLsxpKXpk8APuK-d5J-50HF4BdAGjmJpPkpOQ1U",
    "kty" => "EC",
    "use" => "sig",
    "x" =>
      "AaGpyKIkI5oDXfdBuGEEIUnARSlUFiYx0fwwXqgQy4qyNthel0Rk8bFTwR4_R7yr7FN5lu9DY2G3Yyhr13b9F2e4",
    "y" =>
      "ABHa0GzAhxsmJkS5JvFMk3MHIoG4jw1MNigpzU6LyBWO9zWFQ636J9H0mOISk835dkqws_MKOND4EeRhlbIHZRP7"
  }

# Configure your database
config :re, Re.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "postgres",
  database: "re_test",
  hostname: System.get_env("DATABASE_POSTGRESQL_HOSTNAME") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :account_kit,
  app_id: "123"

config :re, ReWeb.Notifications.Emails.Mailer, adapter: Swoosh.Adapters.Test

config :re, :visualizations, Re.TestVisualizations
config :re, :emails, ReWeb.TestEmails
config :re, :elasticsearch, ReWeb.TestSearch
config :re, :http, Re.TestHTTP
config :re, :pipedrive, ReWeb.TestPipedriveServer
config :re, :account_kit, Re.TestAccountKit

config :re,
  pipedrive_webhook_user: "testuser",
  pipedrive_webhook_pass: "testpass"
