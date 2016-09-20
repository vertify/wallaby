defmodule Wallaby.DSL.Actions.ClickLinkTest do
  use Wallaby.SessionCase, async: true

  test "clicking links takes you to a new page and returns the session", %{session: session, server: server} do
    page =
      session
      |> visit(server.base_url)
      |> find("ul")
      |> click_link("Page 1")

    page
    |> find("h1", text: "Page 1")
  end
end
