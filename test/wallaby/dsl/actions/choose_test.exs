defmodule Wallaby.Actions.ChooseTest do
  use Wallaby.SessionCase, async: true

  setup %{session: session, server: server} do
    page =
      session
      |> visit(server.base_url <> "forms.html")

    {:ok, page: page}
  end

  test "choosing a radio button", %{page: page} do
    refute page |> has_checked_field?("option2")

    page
    |> choose("option2")

    assert page |> has_checked_field?("option2")
  end

  test "choosing a radio button unchecks other buttons in the group", %{page: page} do
    page
    |> choose("Option 1")

    page
    |> has_checked_field?("option1")
    |> assert

    page
    |> choose("option2")

    refute has_checked_field?(page, "option1")
    assert has_checked_field?(page, "option2")
  end

  test "choosing a radio button returns the parent", %{page: page} do
    page
    |> choose("Option 1")
    |> choose("option2")

    assert has_checked_field?(page, "option2")
  end

  test "throw an error if a label exists but does not have a for attribute", %{page: page} do
    bad_form =
      page
      |> find(".bad-form")

    assert_raise Wallaby.QueryError, fn ->
      choose(bad_form, "Radio with bad label")
    end
  end

  test "waits until the radio button appears", %{page: page} do
    assert choose(page, "Hidden Radio Button")
  end

  test "escape quotes", %{page: page} do
    assert choose(page, "I'm a radio button")
  end
end
