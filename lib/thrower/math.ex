defmodule Thrower.Math do

  def calculate_path(0, 0), do: 0
  def calculate_path(0, y_val), do: y_val
  def calculate_path(x_val, 0), do: x_val
  def calculate_path(x_val, y_val) do
    (:math.pow(x_val, 2) + :math.pow(y_val, 2))
    |> :math.sqrt()
    |> round()
  end
end
