defmodule Wallaby.DSL.Navigation do
  @type t :: Wallaby.Session.t | Wallaby.Node.t

  alias Wallaby.{Session, Driver, Drivable}

  @doc """
  Changes the current page to the provided route.
  Relative paths are appended to the provided base_url.
  Absolute paths do not use the base_url.
  """
  @spec visit(t, String.t) :: t

  def visit(parent, path) do
    uri = URI.parse(path)

    cond do
      uri.host == nil && String.length(base_url) == 0 ->
        raise Wallaby.NoBaseUrl, path
      uri.host ->
        Driver.visit(parent, path)
      true ->
        Driver.visit(parent, request_url(path))
    end

    parent
  end

  @doc """
  Gets the title for the current page
  """
  def page_title(parent) do
    parent
    |> Drivable.page
    |> Session.page_title
  end

  def current_url(parent) do
    parent
    |> Drivable.page
    |> Session.get_current_url
  end

  def current_path(parent) do
    parent
    |> Drivable.page
    |> Session.get_current_path
  end

  defp request_url(path) do
    base_url <> path
  end

  defp base_url do
    Application.get_env(:wallaby, :base_url) || ""
  end
end
