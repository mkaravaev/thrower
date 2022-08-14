defmodule ThrowerWeb.ThrowerView do
  use ThrowerWeb, :view

  def render("throw.json", %{radar_entries: [entry]}) do
    render_one(entry, __MODULE__, "target.json")
  end

  def render("throw.json", %{radar_entries: entries}) do
    render_many(entries, __MODULE__, "target.json")
  end

  def render("target.json", %{thrower: thrower}) do
    %{
      position: thrower.position,
      villains: Enum.map(thrower.villains, &(&1.costume))
    }
  end
end
