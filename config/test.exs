import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :thrower, ThrowerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jNIHT7ccMWxLvj14cYEvqNBjPezfoDSi4c26bWOwgNJw0nG8Oyaik+iO9b9IBMvo",
  server: false

# In test we don't send emails.
config :thrower, Thrower.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
