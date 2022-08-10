defmodule Thrower.RadarEntry do
  @enforce_keys [:position, :villains]

  defstruct @enforce_keys

  def new(%{"position" => position, "villains" => villains}) do
    %__MODULE__{
      position: __MODULE__.Position.new(position),
      villains: parse_villains(villains)
    }
  end

  defp parse_villains(villains) do
    Enum.map(villains, &__MODULE__.Villain.new/1)
  end

  defmodule Position do
    defstruct [x: 0, y: 0]

    def new(%{"x" => x, "y" => y}) do
      %__MODULE__{
        x: x,
        y: y
      }
    end
  end

  defmodule Villain do
    @enforce_keys [:costume]
    # @allowed_costumes ~a() #TODO maybe

    defstruct [:costume, malice: 0]

    def new(%{"costume" => costume} = params) do
      %__MODULE__{
        costume: costume,
        malice: Map.get(params, "malice", 0)
      }
    end
  end

end
