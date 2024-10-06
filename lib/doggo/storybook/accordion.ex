defmodule Doggo.Storybook.Accordion do
  @moduledoc false
  alias PhoenixStorybook.Stories.Variation

  def variations(_opts) do
    [
      %Variation{
        id: :all_expanded,
        attributes: %{
          id: "dog-breeds-all-exp"
        },
        slots: slots()
      },
      %Variation{
        id: :first_expanded,
        attributes: %{
          id: "dog-breeds-first-exp",
          expanded: :first
        },
        slots: slots()
      },
      %Variation{
        id: :all_collapsed,
        attributes: %{
          id: "dog-breeds-all-col",
          expanded: :none
        },
        slots: slots()
      },
      %Variation{
        id: :with_controls,
        attributes: %{
          id: "dog-breeds-with-controls",
          expanded: :all,
          show_controls: true
        },
        slots: slots()
      },
      %Variation{
        id: :remember_state,
        attributes: %{
          id: "dog-breeds-remember-state",
          expanded: :all,
          show_controls: true,
          remember_state: true
        },
        slots: slots()
      }
    ]
  end

  def modifier_variation_base(id, _name, _value, _opts) do
    %{
      attributes: %{
        id: id,
        expanded: :first
      },
      slots: slots()
    }
  end

  defp slots do
    [
      """
      <:section title="Golden Retriever">
        <p>
          Friendly, intelligent, great with families. Origin: Scotland. Needs
          regular exercise.
        </p>
      </:section>
      """,
      """
      <:section title="Siberian Husky">
        <p>
          Energetic, outgoing, distinctive appearance. Origin: Northeast Asia.
          Loves cold climates.
        </p>
      </:section>
      """,
      """
      <:section title="Dachshund">
        <p>
          Playful, stubborn, small size. Origin: Germany. Enjoys sniffing games.
        </p>
      </:section>
      """
    ]
  end
end
