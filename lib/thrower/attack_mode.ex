defmodule Thrower.AttackMode do
  @type radar_entry :: map() #TODO wrap into struct
  @type reason :: atom()

  @callback apply([radar_entry()]) :: :ok | {:error, reason()}

end
