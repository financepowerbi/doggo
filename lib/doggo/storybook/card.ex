defmodule Doggo.Storybook.Card do
  @moduledoc false
  alias PhoenixStorybook.Stories.Variation

  def variations do
    [
      %Variation{
        id: :default,
        slots: slots()
      }
    ]
  end

  def modifier_variation(name, value) do
    %{
      attributes: %{name => value},
      slots: slots()
    }
  end

  defp slots do
    [
      """
      <:image>
        <img
          src="https://github.com/woylie/doggo/blob/main/assets/dog_poncho.jpg?raw=true"
          alt="A dog wearing a colorful poncho walks down a fashion show runway."
        />
      </:image>
      """,
      """
      <:main>
        The next dog fashion show is coming up quickly. Here's what you need
        to look out for.
      </:main>
      """,
      """
      <:header><h2>Dog Fashion Show</h2></:header>
      """,
      """
      <:footer>
        <span>2023-11-15 12:24</span>
        <span>Events</span>
      </:footer>
      """
    ]
  end
end
