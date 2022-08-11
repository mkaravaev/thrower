defmodule Thrower.AttackMode.AvoidCrossfireTest do
  use ExUnit.Case
  alias Thrower.AttackMode
  alias Thrower.RadarEntry

  test "should return only entry w/o good characters" do
    entries = [
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 40},
        villains: [
          %RadarEntry.Villain{costume: "Donald Duck", malice: 0}
        ]
      },
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 20},
        villains: [%RadarEntry.Villain{costume: "Voldemort", malice: 20}]
      },
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 30},
        villains: [%RadarEntry.Villain{costume: "Darth Vader", malice: 20}]
      }
    ]

    assert %{position: %{x: 0, y: 20}} = AttackMode.AvoidCrossfire.apply(entries)
  end
end
