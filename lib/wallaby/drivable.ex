defprotocol Wallaby.Drivable do
  @doc """
  Returns the top level page for the element
  """
  def page(parent)

  @doc """
  Transforms the element into text
  """
  def visible_text(parent)
end
