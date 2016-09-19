defmodule Wallaby.DSL.Element.TextTest do
  use Wallaby.SessionCase, async: true

  setup %{server: server, session: session} do
    page =
      session
      |> visit(server.base_url)

    {:ok, %{page: page}}
  end

  test "can get text of an element", %{page: page} do
    text =
      page
      |> find("#header")
      |> text

    assert text == "Test Index"
  end

  test "can get text of an element and its descendants", %{page: page} do
    text =
      page
      |> find("#parent")
      |> text

    assert text == "The Parent\nThe Child"
  end

  test "can get the text of the page", %{page: page} do
    text =
      page
      |> text

    assert text == "Test Index\nPage 1\nPage 2\nPage 3\nThe Parent\nThe Child"
  end
end
