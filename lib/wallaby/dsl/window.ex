defmodule Wallaby.DSL.Window do
  alias Wallaby.Session
  alias Wallaby.Driver

  def set_window_size(parent, width, height) do
    parent
    |> Session.set_window_size(width, height)

    parent
  end

  def get_window_size(parent) do
    Session.get_window_size(parent)
  end

  def take_screenshot(screenshotable) do
    image_data =
      screenshotable
      |> Driver.take_screenshot

    path = path_for_screenshot
    File.write! path, image_data

    Map.update(screenshotable, :screenshots, [], &(&1 ++ [path]))
  end

  def execute_script(parent, script, arguments \\ []) do
    parent
    |> Session.execute_script(script, arguments)
  end

  defp path_for_screenshot do
    File.mkdir_p!(screenshot_dir)
    "#{screenshot_dir}/#{:erlang.system_time}.png"
  end

  defp screenshot_dir do
    Application.get_env(:wallaby, :screenshot_dir) || "#{File.cwd!()}/screenshots"
  end
end
