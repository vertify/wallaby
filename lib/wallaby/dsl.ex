defmodule Wallaby.DSL do
  @moduledoc false

  defmacro __using__([]) do
    quote do
      import Wallaby.DSL.Finders
      import Wallaby.DSL.Navigation
      import Wallaby.DSL.Actions
      import Wallaby.DSL.Element
      import Wallaby.DSL.Matchers
      import Wallaby.DSL.Window
    end
  end
end
