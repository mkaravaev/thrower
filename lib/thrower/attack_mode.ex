defmodule Thrower.AttackMode do
  # TODO wrap into struct
  @type radar_entry :: map()
  @type reason :: atom()

  @callback apply([radar_entry()]) :: :ok | {:error, reason()}
end
