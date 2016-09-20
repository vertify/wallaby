defmodule Wallaby.DSL.Window.CurrentUrlTest do
  use Wallaby.SessionCase, async: true

  test "gets the current_url of the session", %{server: server, session: session}  do
    current_url =
      session
      |> visit(server.base_url)
      |> click_link("Page 1")
      |> current_url

    assert current_url == "http://localhost:#{URI.parse(current_url).port}/page_1.html"
  end

  test "gets the current_path of the session", %{server: server, session: session}  do
    current_path =
      session
      |> visit(server.base_url)
      |> click_link("Page 1")
      |> current_path

    assert current_path == "/page_1.html"
  end
end
