defmodule ThrowerWeb.ThrowerController do
  use ThrowerWeb, :controller

  alias Thrower.Processor
  alias Thrower.RadarEntry

  def throw(conn, %{"attack-mode" => attack_mode, "radar" => radar_entries_params}) do
    parsed_radar_entries = parse_radar_entries(radar_entries_params)
    parsed_attack_modes = parse_attack_modes(attack_mode)
    resulting_radar_entries = Processor.run(parsed_attack_modes, parsed_radar_entries)

    render(conn, "throw.json", %{radar_entries: resulting_radar_entries})
  end

  defp parse_radar_entries(radar_entries) do
    Enum.map(radar_entries, &RadarEntry.new/1)
  end

  defp parse_attack_modes(attack_modes) do
    Enum.map(attack_modes, fn(mode) ->
      mode
      |> String.replace("-", "_")
      |> String.to_existing_atom()
    end)
  end
end
