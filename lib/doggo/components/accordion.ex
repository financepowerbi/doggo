defmodule Doggo.Components.Accordion do
  @moduledoc false

  @behaviour Doggo.Component

  use Phoenix.Component

  @impl true
  def doc do
    """
    Renders a set of headings that control the visibility of their content
    sections.
    """
  end

  @impl true
  def usage do
    """
    ```heex
    <.accordion id="dog-breeds">
      <:section title="Golden Retriever">
        <p>
          Friendly, intelligent, great with families. Origin: Scotland. Needs
          regular exercise.
        </p>
      </:section>
      <:section title="Siberian Husky">
        <p>
          Energetic, outgoing, distinctive appearance. Origin: Northeast Asia.
          Loves cold climates.
        </p>
      </:section>
      <:section title="Dachshund">
        <p>
          Playful, stubborn, small size. Origin: Germany. Enjoys sniffing games.
        </p>
      </:section>
    </.accordion>
    ```
    """
  end

  @impl true
  def config do
    [
      type: :data,
      since: "0.6.0",
      maturity: :developing,
      modifiers: []
    ]
  end

  @impl true
  def nested_classes(_) do
    []
  end

  @impl true
  def attrs_and_slots do
    quote do
      attr :id, :string, required: true

      attr :expanded, :atom,
        values: [:all, :none, :first],
        default: :all,
        doc: """
        Defines how the accordion sections are initialized.

        - `:all` - All accordion sections are expanded by default.
        - `:none` - All accordion sections are hidden by default.
        - `:first` - Only the first accordion section is expanded by default.
        """

      attr :heading, :string,
        default: "h3",
        values: ["h2", "h3", "h4", "h5", "h6"],
        doc: """
        The heading level for the section title (trigger).
        """

      attr :rest, :global, doc: "Any additional HTML attributes."

      attr :show_controls, :boolean, default: false,
        doc: "Whether to show 'Open all' and 'Close all' controls"

      attr :remember_state, :boolean, default: false,
        doc: "Whether to remember the open/closed state of sections"

      slot :section, required: true do
        attr :title, :string
      end
    end
  end

  @impl true
  def init_block(_opts, _extra) do
    []
  end

  @impl true
  def render(assigns) do
    section_count = length(assigns.section)
    assigns = assign(assigns, :section_count, section_count)

    ~H"""
    <div id={@id} class="accordion" {@rest}>
      <div class="accordion-header">
        <span class="accordion-section-count"><%= @section_count %> sections</span>
        <%= if @show_controls do %>
          <div class="accordion-controls">
            <button class="accordion-open-all" type="button" phx-no-format>Open all</button>
            <button class="accordion-close-all" type="button" phx-no-format>Close all</button>
          </div>
        <% end %>
      </div>
      <.section
        :for={{section, index} <- Enum.with_index(@section, 1)}
        section={section}
        index={index}
        id={@id}
        expanded={@expanded}
        heading={@heading}
        remember_state={@remember_state}
      />
    </div>

    <script>
      (() => {
        const accordion = document.getElementById('<%= @id %>');
        const openAllBtn = accordion.querySelector('.accordion-open-all');
        const closeAllBtn = accordion.querySelector('.accordion-close-all');
        const sections = accordion.querySelectorAll('.accordion-section');

        function toggleAllSections(expand) {
          sections.forEach(section => {
            const trigger = section.querySelector('.accordion-trigger');
            const content = section.querySelector('.accordion-content');
            trigger.setAttribute('aria-expanded', expand);
            content.hidden = !expand;
          });
        }

        openAllBtn?.addEventListener('click', () => toggleAllSections(true));
        closeAllBtn?.addEventListener('click', () => toggleAllSections(false));
      })();
    </script>
    """
  end

  @doc false
  def section(assigns) do
    expanded = section_expanded?(assigns.index, assigns.expanded)
    assigns = assign(assigns, aria_expanded: to_string(expanded))

    ~H"""
    <div class="accordion-section" data-index={@index}>
      <.dynamic_tag name={@heading}>
        <button
          id={"#{@id}-trigger-#{@index}"}
          type="button"
          aria-expanded={@aria_expanded}
          aria-controls={"#{@id}-section-#{@index}"}
          class="accordion-trigger"
          phx-click={Doggo.toggle_accordion_section(@id, @index, @remember_state)}
        >
          <span><%= @section.title %></span>
        </button>
      </.dynamic_tag>
      <div
        id={"#{@id}-section-#{@index}"}
        role="region"
        aria-labelledby={"#{@id}-trigger-#{@index}"}
        hidden={@aria_expanded != "true"}
        class="accordion-content"
      >
        <%= render_slot(@section) %>
      </div>
    </div>
    """
  end

  @doc false
  def section_expanded?(_, :all), do: true
  def section_expanded?(_, :none), do: false
  def section_expanded?(1, :first), do: true
  def section_expanded?(_, :first), do: false

end
