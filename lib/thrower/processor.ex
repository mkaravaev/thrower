defmodule Thrower.Processor do
  alias Thrower.RadarEntry

  def run(attack_modes, indexed_radar_entries) do
    do_run(attack_modes, indexed_radar_entries)
  end

  defp do_run(attack_modes, indexed_radar_entries, prev_mode \\ nil, acc \\ [])
  defp do_run([], _indexed_radar_entries, _prev_mode, acc), do: acc

  defp do_run([attack_mode | tail], indexed_radar_entries, prev_mode, acc) do
    if mode_applicable?(attack_mode, prev_mode) do
      with {:ok, result} <- impl(attack_mode).apply(indexed_radar_entries) do
        do_run(tail, indexed_radar_entries, attack_mode, [result|acc])
      end
    else
      do_run(tail, indexed_radar_entries, prev_mode, acc)
    end
  end


  def parse_radar_entries(radar_entries) do
    Enum.map(radar_entries, &RadarEntry.new/1)
  end

  def mode_applicable?(current_mode, prev_mode) do
    ! impl(current_mode).opposite_to?(prev_mode)
  end

  def impl(mode_name) do
    Application.get_env(Thrower, :attack_modes)[mode_name]
  end
end
