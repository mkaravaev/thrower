defmodule Thrower.AttackMode do
  # TODO wrap into struct
  @type radar_entry :: map()
  @type reason :: atom()
  @type attack_mode :: atom()

  @callback apply([radar_entry()]) :: :ok | {:error, reason()}
  @callback opposite_to?(attack_mode()) :: boolean()
end
