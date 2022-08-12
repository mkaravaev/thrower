defmodule Thrower.ProcessorTest do
  use ExUnit.Case

  alias Thrower.Processor
  alias Thrower.RadarEntry

  describe "parse_radar_entries/1" do
    test "should wrap params into RadarEntries structs" do
      assert [
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
             ] =
               Processor.parse_radar_entries(test_params())
    end

    test "should raise an error in case bad params" do
      bad_params = [
        %{
          "position" => %{
            "x" => 0,
            "z" => 40
          },
          "villains" => [
            %{
              "costume" => "Donald Duck"
            }
          ]
        }
      ]

      assert_raise(FunctionClauseError, fn ->
        Processor.parse_radar_entries(bad_params)
      end)
    end
  end

  describe "run/2" do
    test "should process several attack modes" do
      assert [
        %{position: %{x: 0, y: 40},
          villains: [
            %{costume: "Shir Khan"},
            %{costume: "Voldemort"}]
        }, 
        %{position: %{x: 0, y: 20},
          villains: [%{costume: "Darth Vader"}]
         }
      ] = 
       test_params_2()
       |> Processor.parse_radar_entries()
       |> then(&Processor.run([:furthest_first, :prioritize_vader], &1))
    end

    test "should not process opposite mode" do
      assert [
        %{position: %{x: 0, y: 40},
          villains: [
            %{costume: "Shir Khan"},
            %{costume: "Voldemort"}]
        }
      ] =
       test_params_2()
       |> Processor.parse_radar_entries()
       |> then(&Processor.run([:furthest_first, :closest_first], &1))
    end
  end

  defp test_params do
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
            "costume" => "Voldemort"
          },
          %{
            "costume" => "Donald Duck"
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
          }
        ]
      }
    ]
  end

  defp test_params_2 do
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
            "costume" => "Voldemort"
          },
          %{
            "costume" => "Donald Duck"
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
  end
end
