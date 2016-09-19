defmodule Wallaby.DSL.Finders do
  alias Wallaby.Node.Query

  @doc """
  Finds a specific DOM node on the page based on a css selector. Blocks until
  it either finds the node or until the max time is reached. By default only
  1 node is expected to match the query. If more nodes are present then a
  count can be specified. By default only nodes that are visible on the page
  are returned.

  Selections can be scoped by providing a Node as the locator for the query.
  """
  # @spec find(locator, query, Keyword.t) :: t | list(t)

  def find(parent, query, opts \\ []) do
    Query.find(parent, query, opts)
  end

  @doc """
  Finds all of the DOM nodes that match the css selector. If no elements are
  found then an empty list is immediately returned.
  """
  # @spec all(locator, query) :: list(t)

  def all(parent, query, opts \\ []) do
    Query.all(parent, query, opts)
  end
end
