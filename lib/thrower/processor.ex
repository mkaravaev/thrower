defmodule Thrower.Processor do
  @moduledoc """
  TODO
  """

  def run(attack_modes, radar_entries) do
    do_run(attack_modes, radar_entries)
  end

  defp do_run(attack_modes, radar_entries, prev_mode \\ nil, acc \\ [])
  defp do_run([], _radar_entries, _prev_mode, acc), do: acc

  defp do_run([attack_mode | tail], radar_entries, prev_mode, acc) do
    if mode_applicable?(attack_mode, prev_mode) do
      result = impl(attack_mode).apply(radar_entries)
      do_run(tail, radar_entries, attack_mode, [result | acc])
    else
      do_run(tail, radar_entries, prev_mode, acc)
    end
  end

  def mode_applicable?(_current_mode, nil), do: true
  def mode_applicable?(current_mode, prev_mode) do
    !impl(current_mode).opposite_to?(prev_mode)
  end

  def impl(mode_name) do
    Application.get_env(:thrower, :attack_modes)[mode_name]
  end
end
