document.addEventListener('DOMContentLoaded', () => {
    const faqItems = document.querySelectorAll('.faq-item');
  
    faqItems.forEach(item => {
      item.addEventListener('click', () => {
        item.classList.toggle('active');
  
        const answer = item.querySelector('.faq-answer');
        if (item.classList.contains('active')) {
          answer.style.display = 'block';
        } else {
          answer.style.display = 'none';
        }
      });
    });
  });