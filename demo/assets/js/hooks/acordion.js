let Accordion = {
  mounted() {
    this.handleSaveState = (event) => {
      const accordion = event.target;
      const state = {};
      accordion.querySelectorAll('.accordion-section').forEach(section => {
        const index = section.dataset.index;
        const trigger = section.querySelector('.accordion-trigger');
        state[index] = trigger.getAttribute('aria-expanded') === 'true';
      });
      localStorage.setItem(accordion.id, JSON.stringify(state));
    };

    this.handleToggleAll = (event) => {
      const accordion = event.target;
      const expand = event.detail.expand;
      const triggers = accordion.querySelectorAll('.accordion-trigger');
      const contents = accordion.querySelectorAll('.accordion-content');
    
      triggers.forEach(trigger => trigger.setAttribute('aria-expanded', expand));
      contents.forEach(content => content.hidden = !expand);
    
      if (accordion.dataset.rememberState === "true") {
        const state = {};
        accordion.querySelectorAll('.accordion-section').forEach(section => {
          const index = section.dataset.index;
          state[index] = expand;
        });
        localStorage.setItem(accordion.id, JSON.stringify(state));
      }
    };

    this.restoreState = () => {
      if (this.el.dataset.rememberState === "true") {
        const state = JSON.parse(localStorage.getItem(this.el.id) || '{}');
        this.el.querySelectorAll('.accordion-section').forEach(section => {
          const index = section.dataset.index;
          if (state.hasOwnProperty(index)) {
            const trigger = section.querySelector('.accordion-trigger');
            const content = section.querySelector('.accordion-content');
            trigger.setAttribute('aria-expanded', state[index]);
            content.hidden = !state[index];
          }
        });
      }
    };

    this.el.addEventListener("accordion:save-state", this.handleSaveState);
    this.el.addEventListener("accordion:toggle-all", this.handleToggleAll);
    
    // Restore state on mount
    this.restoreState();

    // Restore state on page show (e.g., when navigating back to the page)
    window.addEventListener("pageshow", this.restoreState);
  },

  destroyed() {
    this.el.removeEventListener("accordion:save-state", this.handleSaveState);
    this.el.removeEventListener("accordion:toggle-all", this.handleToggleAll);
    window.removeEventListener("pageshow", this.restoreState);
  }
};

export { Accordion }