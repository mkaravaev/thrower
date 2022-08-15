defmodule ThrowerWeb.ThrowerController do
  use ThrowerWeb, :controller

  alias Thrower.Processor
  alias Thrower.Parser

  def throw(conn, %{"attack-mode" => attack_mode, "radar" => radar_entries_params}) do
    parsed_radar_entries = Parser.parse_radar_entries(radar_entries_params)
    parsed_attack_modes = Parser.parse_attack_modes(attack_mode)
    resulting_radar_entries = Processor.run(parsed_attack_modes, parsed_radar_entries)

    render(conn, "throw.json", %{radar_entries: resulting_radar_entries})
  end

end
