defmodule Doggo.Storybook.Skeleton do
  @moduledoc false

  def variations do
    # The skeleton component only becomes useful through the type modifier,
    # which is covered by the modifier variation groups.
    []
  end

  def modifier_variation(name, value) do
    %{
      attributes: %{name => value}
    }
  end
end
