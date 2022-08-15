defmodule ThrowerWeb.ThrowerView do
  use ThrowerWeb, :view

  def render("throw.json", %{radar_entries: [entry]}) do
    render_one(entry, __MODULE__, "target.json")
  end

  def render("throw.json", %{radar_entries: entries}) do
    #NOTE only first entry returned because in tests with chain of attacks we return only first target
    render_one(hd(entries), __MODULE__, "target.json")
  end

  def render("target.json", %{thrower: thrower}) do
    %{
      position: thrower.position,
      villains: Enum.map(thrower.villains, &(&1.costume))
    }
  end
end
