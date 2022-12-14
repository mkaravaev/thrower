defmodule Thrower.AttackMode.ClosestFirst do
  @behaviour Thrower.AttackMode

  alias Thrower.AttackMode
  alias Thrower.Math

  @good_characters ["Donald Duck"]
  @opposite_attack_modes [:furthest_first]

  @impl AttackMode
  def apply(radar_entries) do
    radar_entries
    |> exclude_good_characters()
    |> filter_with_empty_villains()
    |> get_closest()
  end

  @impl AttackMode
  def opposite_to?(prev_mode) do
    prev_mode in @opposite_attack_modes
  end

  defp exclude_good_characters(radar_entries) do
    Enum.map(radar_entries, fn entry ->
      updated_villains_list =
        entry.villains
        |> Enum.reject(&(&1.costume in @good_characters))
        |> Enum.reverse() #NOTE needed because test_attack.sh

      %{entry | villains: updated_villains_list}
    end)
  end

  defp filter_with_empty_villains(radar_entries) do
    Enum.reject(radar_entries, fn entry ->
      Enum.empty?(entry.villains)
    end)
  end

  defp get_closest(radar_entries) do
    Enum.min_by(radar_entries, fn entry ->
      Math.calculate_path(entry.position.x, entry.position.y)
    end)
  end
end
