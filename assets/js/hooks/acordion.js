export function initAccordions() {
  const accordions = document.querySelectorAll('.accordion');
  
  accordions.forEach(accordion => {
    accordion.addEventListener('click', (e) => {
      if (e.target.matches('.accordion-trigger')) {
        const section = e.target.closest('.accordion-section');
        const content = section.querySelector('.accordion-content');
        const expanded = content.hidden;
        content.hidden = !expanded;
        e.target.setAttribute('aria-expanded', expanded.toString());
      }

      if (e.target.matches('.accordion-open-all')) {
        accordion.querySelectorAll('.accordion-content').forEach(content => {
          content.hidden = false;
        });
        accordion.querySelectorAll('.accordion-trigger').forEach(trigger => {
          trigger.setAttribute('aria-expanded', 'true');
        });
      }

      if (e.target.matches('.accordion-close-all')) {
        accordion.querySelectorAll('.accordion-content').forEach(content => {
          content.hidden = true;
        });
        accordion.querySelectorAll('.accordion-trigger').forEach(trigger => {
          trigger.setAttribute('aria-expanded', 'false');
        });
      }
    });
  });
}