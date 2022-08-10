defmodule Thrower.Processor do
  alias Thrower.RadarEntry

  def run do
  end

  def parse_radar_entries(radar_entries) do
    Enum.map(radar_entries, &RadarEntry.new/1)
  end
end
