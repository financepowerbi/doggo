defmodule Storybook.Components.Accordion do
  use PhoenixStorybook.Story, :component

  use Doggo.Storybook,
    module: Elixir.DemoWeb.CoreComponents,
    name: :disclosure_button
end
