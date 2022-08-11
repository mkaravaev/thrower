defmodule Thrower.AttackMode.ClosestFirst do
  @behaviour Thrower.AttackMode
  alias Thrower.AttackMode

  @good_characters ["Donald Duck"]

  @impl AttackMode
  def apply(radar_entries) do
    radar_entries
    |> exclude_good_characters()
    |> filter_with_empty_villains()
    |> get_closest()
  end

  def opposite_to?(mode) do
    false
    # mode in @opposite_attack_modes
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

  defp get_closest(radar_entries) do
    Enum.min_by(radar_entries, fn entry -> entry.position.x + entry.position.y end)
  end
end
