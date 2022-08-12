defmodule Thrower.AttackMode.FurthestFirst do
  @behaviour Thrower.AttackMode
  alias Thrower.AttackMode

  @good_characters ["Donald Duck"]
  @opposite_attack_modes [:closest_first]

  @impl AttackMode
  def apply(radar_entries) do
    radar_entries
    |> exclude_good_characters()
    |> filter_with_empty_villains()
    |> get_furthest()
  end

  @impl AttackMode
  def opposite_to?(prev_mode) do
    prev_mode in @opposite_attack_modes
  end

  defp exclude_good_characters(radar_entries) do
    Enum.map(radar_entries, fn entry ->
      updated_villains_list = Enum.reject(entry.villains, &(&1.costume in @good_characters))
      %{entry | villains: updated_villains_list}
    end)
  end

  defp filter_with_empty_villains(radar_entries) do
    Enum.reject(radar_entries, fn entry ->
      Enum.empty?(entry.villains)
    end)
  end

  defp get_furthest(radar_entries) do
    Enum.max_by(radar_entries, fn entry -> entry.position.x + entry.position.y end)
  end
end
