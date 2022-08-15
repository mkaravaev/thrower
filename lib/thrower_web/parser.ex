defmodule Thrower.Parser do
  alias Thrower.RadarEntry

  def parse_radar_entries(radar_entries) do
    Enum.map(radar_entries, &RadarEntry.new/1)
  end

  def parse_attack_modes(attack_modes) do
    Enum.map(attack_modes, fn(mode) ->
      mode
      |> String.replace("-", "_")
      |> String.to_existing_atom()
    end)
  end
end
