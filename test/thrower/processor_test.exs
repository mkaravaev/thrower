defmodule Thrower.ProcessorTest do
  use ExUnit.Case

  alias Thrower.Processor
  alias Thrower.Parser

  describe "run/2" do
    test "should process several attack modes" do
      assert [
        %{position: %{x: 0, y: 40},
          villains: [
            %{costume: "Voldemort"},
            %{costume: "Shir Khan"}
          ]
        },
        %{position: %{x: 0, y: 20},
          villains: [%{costume: "Darth Vader"}]
         }
      ] =
       Processor.run([:furthest_first, :prioritize_vader], test_params())
    end

    test "should not process opposite mode" do
      assert [
        %{position: %{x: 0, y: 40},
          villains: [
            %{costume: "Voldemort"},
            %{costume: "Shir Khan"}
          ]
        }
      ] =
       Processor.run([:furthest_first, :closest_first], test_params())
    end
  end

  defp test_params do
    Parser.parse_radar_entries(
      [
        %{
          "position" => %{
            "x" => 0,
            "y" => 40
          },
          "villains" => [
            %{
              "costume" => "Shir Khan",
              "malice" => 80
            },
            %{
              "costume" => "Donald Duck"
            },
            %{
              "costume" => "Voldemort"
            }
          ]
        },
        %{
          "position" => %{
            "x" => 0,
            "y" => 20
          },
          "villains" => [
            %{
              "costume" => "Donald Duck"
            },

            %{
              "costume" => "Darth Vader"
            }
          ]
        }
      ]
    )
  end
end
