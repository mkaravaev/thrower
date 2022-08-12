defmodule Thrower.AttackMode.PrioritizeVader do
  @behaviour Thrower.AttackMode
  alias Thrower.AttackMode

  @good_characters ["Donald Duck"]

  @impl AttackMode
  def apply(radar_entries) do
    radar_entries
    |> get_with_vader()
    |> exclude_good_characters()
  end

  @impl AttackMode
  def opposite_to?(mode) do
    false
    # mode in @opposite_attack_modes
  end

  defp exclude_good_characters(radar_entry) do
    updated_villains_list = Enum.reject(radar_entry.villains, &(&1.costume in @good_characters))
    %{radar_entry | villains: updated_villains_list}
  end

  defp get_with_vader(radar_entries) do
    Enum.find(radar_entries, fn entry ->
      area_costumes = Enum.map(entry.villains, &(&1.costume))
      "Darth Vader" in area_costumes
    end)
  end
end
