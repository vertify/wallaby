defmodule Wallaby.DSL.Matchers do
  alias Wallaby.Node.Query
  alias Wallaby.Node
  alias Wallaby.Drivable

  @doc """
  Searches for CSS on the page.
  """
  # @spec has_css?(locator, String.t) :: boolean()

  def has_css?(locator, css) when is_binary(css) do
    locator
    |> Query.find(css, [count: :any])
    |> Enum.any?
  end

  @doc """
  Searches for css that should not be on the page
  """
  # @spec has_no_css?(locator, String.t) :: boolean()

  def has_no_css?(locator, css) when is_binary(css) do
    locator
    |> Query.find(css, count: 0)
    |> Enum.empty?
  end

  @doc """
  Matches the Node's value with the provided value.
  """
  # @spec has_value?(t, any()) :: boolean()

  def has_value?(%Node{}=node, value) do
    Node.attr(node, "value") == value
  end

  @doc """
  Matches the Node's content with the provided text and raises if not found
  """
  # @spec assert_text(t, String.t) :: boolean()

  def assert_text(%Node{}=node, text) when is_binary(text) do
    retry fn ->
      regex_results = Regex.run(~r/#{text}/, Drivable.visible_text(node))
      if regex_results |> is_nil do
        raise Wallaby.ExpectationNotMet, "Text '#{text}' not found"
      end
      true
    end
  end

  @doc """
  Matches the Node's content with the provided text
  """
  # @spec has_text?(t, String.t) :: boolean()

  def has_text?(%Node{}=node, text) when is_binary(text) do
    try do
      assert_text(node, text)
    rescue
      _e in Wallaby.ExpectationNotMet -> false
    end
  end

  def has_checked_field?(parent, locator) do
    parent
    |> Query.field(locator, count: :any)
    |> Enum.map(fn(node) -> Node.checked?(node) end)
    |> Enum.any?
  end

  defp retry(find_fn, start_time \\ :erlang.monotonic_time(:milli_seconds)) do
    try do
      find_fn.()
    rescue
      e in [Wallaby.ExpectationNotMet] ->
        current_time = :erlang.monotonic_time(:milli_seconds)
        if (current_time - start_time) < Wallaby.max_wait_time do
          :timer.sleep(25)
          retry(find_fn, start_time)
        else
          raise e
        end
    end
  end
end
