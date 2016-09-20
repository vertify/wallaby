defmodule Wallaby.DSL.Element do
  alias Wallaby.Drivable

  def text(parent) do
    Drivable.visible_text(parent)
  end
end
