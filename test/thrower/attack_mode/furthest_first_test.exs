defmodule Thrower.AttackMode.FurthestFirstTest do
  use ExUnit.Case
  alias Thrower.AttackMode
  alias Thrower.RadarEntry

  test "should exclude positions with good characters" do
    entries = [
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 40},
        villains: [
          %RadarEntry.Villain{costume: "Shir Khan", malice: 80},
          %RadarEntry.Villain{costume: "Voldemort", malice: 0},
          %RadarEntry.Villain{costume: "Donald Duck", malice: 0}
        ]
      },
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 20},
        villains: [%RadarEntry.Villain{costume: "Donald Duck", malice: 0}]
      }
    ]

    assert %{position: %{x: 0, y: 40}} = AttackMode.FurthestFirst.apply(entries)
  end

  test "should return furthest radar entry" do
    entries = [
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 40},
        villains: [
          %RadarEntry.Villain{costume: "Shir Khan", malice: 80}
        ]
      },
      %RadarEntry{
        position: %RadarEntry.Position{x: 0, y: 20},
        villains: [%RadarEntry.Villain{costume: "Voldemort", malice: 0}]
      }
    ]

    assert %{position: %{x: 0, y: 40}} = AttackMode.FurthestFirst.apply(entries)
  end
end
