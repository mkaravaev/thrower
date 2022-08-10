defmodule Thrower.AttackMode.ClosestFirst do
  @behaviour Thrower.AttackMode
  alias Thrower.AttackMode

  @impl AttackMode
  def apply(indexed_radar_entries) do
    []
  end

  def opposite_to?(mode) do
    false
    # mode in @opposite_attack_modes
  end
end
