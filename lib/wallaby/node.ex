defmodule Wallaby.Node do
  @moduledoc """
  Common functionality for interacting with DOM nodes.
  """

  defstruct [:url, :session_url, :parent, :id, screenshots: []]

  @type url :: String.t
  @type query :: String.t
  @type locator :: Session.t | t
  @type t :: %__MODULE__{
    session_url: url,
    url: url,
    id: String.t,
    screenshots: list,
  }

  alias __MODULE__
  alias Wallaby.Driver
  alias Wallaby.Session

  @default_max_wait_time 3_000

  @doc """
  Fills in the node with the supplied value
  """
  @spec fill_in(Node.t, [with: String.t]) :: Node.t

  def fill_in(%Node{}=node, with: value) when is_binary(value) do
    node
    |> clear
    |> Driver.set_value(value)

    node
  end

  def set(%Node{}=node, value) when is_binary(value) do
    node
    |> Driver.set_value(value)

    node
  end

  @doc """
  Clears an input field. Input nodes are looked up by id, label text, or name.
  The node can also be passed in directly.
  """
  @spec clear(Node.t) :: Session.t

  def clear(node) do
    Driver.clear(node)
    node
  end

  @doc """
  Chooses a radio button.
  """
  @spec choose(Node.t) :: Node.t

  def choose(%Node{}=node) do
    click(node)
  end

  @doc """
  Marks a checkbox as "checked".
  """
  @spec check(Node.t) :: Node.t

  def check(%Node{}=node) do
    unless checked?(node) do
      click(node)
    end
    node
  end

  @doc """
  Unchecks a checkbox.
  """
  @spec uncheck(t) :: t

  def uncheck(%Node{}=node) do
    if checked?(node) do
      click(node)
    end
    node
  end

  @doc """
  Clicks a node.
  """
  @spec click(t) :: Session.t

  def click(node) do
    Driver.click(node)
    node
  end

  @doc """
  Gets the Node's text value.
  """
  @spec text(t) :: String.t

  def text(node) do
    Driver.text(node)
  end

  @doc """
  Gets the value of the nodes attribute.
  """
  @spec attr(t, String.t) :: String.t | nil

  def attr(node, name) do
    Driver.attribute(node, name)
  end

  @doc """
  Gets the selected value of the element.

  For Checkboxes and Radio buttons it returns the selected option.
  """
  @spec selected(t) :: any()

  def selected(node) do
    Driver.selected(node)
  end

  @doc """
  Checks if the node has been selected.
  """
  @spec checked?(t) :: boolean()

  def checked?(node) do
    selected(node) == true
  end

  @doc """
  Checks if the node has been selected. Alias for checked?(node)
  """
  @spec selected?(t) :: boolean()

  def selected?(%Node{}=node) do
    checked?(node)
  end

  @doc """
  Checks if the node is visible on the page
  """
  @spec visible?(t) :: boolean()

  def visible?(%Node{}=node) do
    Driver.displayed(node)
  end
end

defimpl Wallaby.Drivable, for: Wallaby.Node do
  def page(node), do: Wallaby.Drivable.page(node.parent)

  def visible_text(node), do: Wallaby.Node.text(node)
end
