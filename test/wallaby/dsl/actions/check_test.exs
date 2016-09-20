defmodule Wallaby.DSL.Actions.CheckTest do
  use Wallaby.SessionCase, async: true

  alias Wallaby.Node

  setup %{session: session, server: server} do
    page =
      session
      |> visit(server.base_url <> "forms.html")

    {:ok, page: page}
  end

  test "check/1 checks the specified node", %{page: page} do
    checkbox =
      page
      |> find("#checkbox1")

    Node.check checkbox
    assert Node.checked?(checkbox)
    Node.uncheck checkbox
    refute Node.checked?(checkbox)
  end

  test "check/2 does not uncheck the node if called twice", %{page: page} do
    page
    |> check("Checkbox 1")
    |> check("Checkbox 1")

    assert has_checked_field?(page, "checkbox1")
  end

  test "uncheck/2 does not check the node", %{page: page} do
    page
    |> uncheck("Checkbox 1")

    refute has_checked_field?(page, "checkbox1")
  end

  test "check/2 finds the node by label", %{page: page} do
    check(page, "Checkbox 1")
    assert has_checked_field?(page, "checkbox1")
    uncheck(page, "Checkbox 1")
    refute has_checked_field?(page, "checkbox1")
  end

  test "check/2 finds the node by id", %{page: page} do
    check(page, "checkbox1")
    assert has_checked_field?(page, "checkbox1")
    uncheck(page, "checkbox1")
    refute has_checked_field?(page, "checkbox1")
  end

  test "check/2 finds the node by name", %{page: page} do
    check(page, "testbox")
    assert has_checked_field?(page, "checkbox1")
    uncheck(page, "testbox")
    refute has_checked_field?(page, "checkbox1")
  end

  test "throw an error if a label exists but does not have a for attribute", %{page: page} do
    assert_raise Wallaby.QueryError, fn ->
      check(page, "Checkbox with bad label")
    end
  end

  test "waits until the checkbox appears", %{page: page} do
    assert check(page, "Hidden Checkbox")
  end

  test "escapes quotes", %{page: page} do
    assert check(page, "I'm a checkbox")
  end
end
