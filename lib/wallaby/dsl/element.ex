defmodule Wallaby.DSL.Element do
  alias Wallaby.Drivable
  alias Wallaby.Node

  def text(parent) do
    Drivable.visible_text(parent)
  end

  def checked?(parent) do
    Node.checked?(parent)
  end

  def selected?(parent) do
    Node.selected?(parent)
  end

  def visible?(parent) do
    Node.visible?(parent)
  end

  def attr(parent, attr_name) do
    Node.attr(parent, attr_name)
  end
end
