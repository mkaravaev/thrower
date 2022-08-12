defmodule Thrower.AttackMode.AvoidCrossfire do
  @behaviour Thrower.AttackMode
  alias Thrower.AttackMode

  @good_characters ["Donald Duck"]

  @impl AttackMode
  def apply(radar_entries) do
    radar_entries
    |> filter_good_characters_area()
    |> filter_with_empty_villains()
    |> hd()
  end

  @impl AttackMode
  def opposite_to?(mode) do
    false
    # mode in @opposite_attack_modes
  end

  defp filter_good_characters_area(radar_entries) do
    Enum.reject(radar_entries, fn entry ->
      area_costumes = Enum.map(entry.villains, &(&1.costume))
      ! MapSet.disjoint?(MapSet.new(area_costumes), MapSet.new(@good_characters))
    end)
  end

  defp filter_with_empty_villains(radar_entries) do
    Enum.reject(radar_entries, fn entry ->
      Enum.empty?(entry.villains)
    end)
  end
end
