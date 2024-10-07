const Accordion = {
  mounted() {
    const accordion = this.el;
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
  }
};

export default Accordion;